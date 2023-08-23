

drop table [PrescribedMedication]
drop table [Dispensing]
drop table [Prescription]
drop table [Patients]
drop table [Staff]
drop table [Medication]

CREATE TABLE [Patients] (
  [patient_id] int IDENTITY(1,1) NOT NULL,
  [first_name] nvarchar(25),
  [last_name] nvarchar(25),
  [tz] integer,
  [date_of_birth] date,
  [gender] nvarchar(25),
  [cell] nvarchar(25),
  [address] nvarchar(55),
  [created_at] datetime,
   CONSTRAINT [PK_patient_id] PRIMARY KEY CLUSTERED (
	[patient_id] ASC)
)
GO

CREATE TABLE [Staff] (
  [staff_id] int IDENTITY(1,1) NOT NULL,
  [first_name] nvarchar(25),
  [last_name] nvarchar(25),
  [username] nvarchar(25),
  [role] nvarchar(25),
  [cell] nvarchar(25),
  [email] nvarchar(25),
  [created_at] datetime,
   CONSTRAINT [PK_staff_id] PRIMARY KEY CLUSTERED (
	[staff_id] ASC)
)
GO

CREATE TABLE [Prescription] (
  [prescription_id] int IDENTITY(1,1) NOT NULL,
  [patient_id] int NOT NULL,
  [issue_date] date,
  [expiry_date] date,
  [staff_id] int NOT NULL,
  [diagnosis] nvarchar(255),
   CONSTRAINT [PK_prescription_id] PRIMARY KEY CLUSTERED (
	[prescription_id] ASC)
)
GO

CREATE TABLE [PrescribedMedication] (
  [prescribed_medication_id] int IDENTITY(1,1) NOT NULL,
  [prescription_id] int NOT NULL,
  [medication_id] int NOT NULL,
  [approve_staff_id] int NOT NULL,
   CONSTRAINT [PK_prescribed_medication_id] PRIMARY KEY CLUSTERED (
	[prescribed_medication_id] ASC)
)
GO

CREATE TABLE [Medication] (
  [medication_id] int IDENTITY(1,1) NOT NULL,
  [name] nvarchar(25),
  [description] nvarchar(25),
  [quantity_in_stock] int,
  [unit_price] float,
  [manufacturing_date] date,
  [expiration_date] date,
  [created_at] datetime,
   CONSTRAINT [PK_medication_id] PRIMARY KEY CLUSTERED (
	[medication_id] ASC)
)
GO

CREATE TABLE [Dispensing] (
  [dispensing_id] int IDENTITY(1,1) NOT NULL,
  [prescription_id] int NOT NULL,
  [dispense_date] datetime,
  [staff_id] int NOT NULL,
   CONSTRAINT [PK_dispensing_id] PRIMARY KEY CLUSTERED (
	[dispensing_id] ASC)
)
GO

ALTER TABLE [Prescription] WITH CHECK ADD CONSTRAINT [FK_Patients_Prescription] FOREIGN KEY([patient_id]) REFERENCES [Patients]  ([patient_id]) 
GO
ALTER TABLE [Prescription] WITH CHECK ADD CONSTRAINT [FK_Prescription_Staffs] FOREIGN KEY([staff_id]) REFERENCES [Staff]  ([staff_id]) 
GO

ALTER TABLE [Dispensing]  WITH CHECK ADD CONSTRAINT [FK_Dispensing_Staff] FOREIGN KEY([staff_id]) REFERENCES [Staff] ([staff_id]) 
GO
ALTER TABLE [Dispensing]  WITH CHECK ADD CONSTRAINT [FK_Dispensing_Prescription] FOREIGN KEY([prescription_id]) REFERENCES [Prescription] ([prescription_id]) 
GO

ALTER TABLE [PrescribedMedication] WITH CHECK ADD CONSTRAINT [FK_PrescribedMedication_Prescription] FOREIGN KEY([prescription_id]) REFERENCES [Prescription] ([prescription_id]) 
GO
ALTER TABLE [PrescribedMedication]  WITH CHECK ADD CONSTRAINT [FK_PrescribedMedication_Medication] FOREIGN KEY([medication_id]) REFERENCES [Medication] ([medication_id]) 
GO
ALTER TABLE [PrescribedMedication]  WITH CHECK ADD CONSTRAINT [FK_PrescribedMedication_Staff] FOREIGN KEY([approve_staff_id]) REFERENCES [Staff] ([staff_id]) 
GO

