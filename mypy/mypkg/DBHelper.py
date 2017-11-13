

from mypkg.database import db
import mypkg.SampleModelClasses as sampledb
import mypkg.DataModelClasses as datadb
import mypkg.DapModelClasses as dapdb

from sqlalchemy import Column, Integer, ForeignKey

from sqlalchemy.orm import relationship, backref





Base = db.Base;
SpaxelAtts = dapdb.SpaxelAtts;


class C5Cstore(Base, SpaxelAtts):
    __tablename__ = 'c5_cstore'
    __table_args__ = {'autoload': True, 'schema': 'mangadapdb'}
    pk = Column(Integer, primary_key=True)
    #file = relationship('dapdb.File', backref=backref('c5spaxels'),
    #    primaryjoin = 'file.pk==c5_cstore.file_pk',
    #    foreign_keys = 'File.pk')

    #files = relationship(lambda: dapdb.File, primaryjoin=lambda:File.pk==C5Cstore.file_pk)

    file_pk = Column('file_pk', Integer, ForeignKey('mangadapdb.file.pk'))
    #file = relationship('File', backref = 'files')
    def __repr__(self):
        return '<c5_cstore (pk={0}, file={1})'.format(self.pk, self.file_pk)

class C5SSD(Base, SpaxelAtts):
    __tablename__ = 'c5_ssd'
    __table_args__ = {'autoload': True, 'schema': 'mangadapdb'}
    pk = Column(Integer, primary_key=True)
    file_pk = Column('file_pk', Integer, ForeignKey('mangadapdb.file.pk'))
    #file = relationship('File', backref = 'files')
    def __repr__(self):
        return '<c5_ssd (pk={0}, file={1})'.format(self.pk, self.file_pk)



class C5CstoreSSD(Base, SpaxelAtts):
    __tablename__ = 'c5_cstore_ssd'
    __table_args__ = {'autoload': True, 'schema': 'mangadapdb'}
    pk = Column(Integer, primary_key=True)
    # file = relationship('dapdb.File', backref=backref('c5spaxels'),
    #    primaryjoin = 'file.pk==c5_cstore.file_pk',
    #    foreign_keys = 'File.pk')

    # files = relationship(lambda: dapdb.File, primaryjoin=lambda:File.pk==C5Cstore.file_pk)

    file_pk = Column('file_pk', Integer, ForeignKey('mangadapdb.file.pk'))

    # file = relationship('File', backref = 'files')
    def __repr__(self):
        return '<c5_cstore_ssd (pk={0}, file={1})'.format(self.pk, self.file_pk)

class C5cx(Base, SpaxelAtts):
    __tablename__ = 'c5_cx'
    __table_args__ = {'autoload': True, 'schema': 'mangadapdb'}
    pk = Column(Integer, primary_key=True)
    file_pk = Column('file_pk', Integer, ForeignKey('mangadapdb.file.pk'))
    #file = relationship('File', backref = 'files')
    def __repr__(self):
        return '<c5_cx(pk={0}, file={1})'.format(self.pk, self.file_pk)

class C5cxSSD(Base, SpaxelAtts):
    __tablename__ = 'c5_cx_ssd'
    __table_args__ = {'autoload': True, 'schema': 'mangadapdb'}
    pk = Column(Integer, primary_key=True)
    file_pk = Column('file_pk', Integer, ForeignKey('mangadapdb.file.pk'))
    #file = relationship('File', backref = 'files')
    def __repr__(self):
        return '<c5_cx_ssd(pk={0}, file={1})'.format(self.pk, self.file_pk)

class FlatTableTest(Base, SpaxelAtts):
    __tablename__ = 'flattabletest'
    __table_args__ = {'autoload': True, 'schema': 'mangadapdb'}
    pk = Column(Integer, primary_key=True)
    file_pk = Column('file_pk', Integer, ForeignKey('mangadapdb.file.pk'))
    #file = relationship('File', backref = 'files')
    def __repr__(self):
        return '<flattabletest (pk={0}, file={1})'.format(self.pk, self.file_pk)

class FlatTableSSD(Base, SpaxelAtts):
        __tablename__ = 'flat_ssd'
        __table_args__ = {'autoload': True, 'schema': 'mangadapdb'}
        pk = Column(Integer, primary_key=True)
        file_pk = Column('file_pk', Integer, ForeignKey('mangadapdb.file.pk'))

        # file = relationship('File', backref = 'files')
        def __repr__(self):
            return '<flat_ssd (pk={0}, file={1})'.format(self.pk, self.file_pk)

class FlatTableCstore(Base, SpaxelAtts):
    __tablename__ = 'flat_cstore'
    __table_args__ = {'autoload': True, 'schema': 'mangadapdb'}
    pk = Column(Integer, primary_key=True)
    file_pk = Column('file_pk', Integer, ForeignKey('mangadapdb.file.pk'))

    # file = relationship('File', backref = 'files')
    def __repr__(self):
        return '<flat_cstore (pk={0}, file={1})'.format(self.pk, self.file_pk)

class FlatTableCstoreSSD(Base, SpaxelAtts):
        __tablename__ = 'flat_cstore_ssd'
        __table_args__ = {'autoload': True, 'schema': 'mangadapdb'}
        pk = Column(Integer, primary_key=True)
        file_pk = Column('file_pk', Integer, ForeignKey('mangadapdb.file.pk'))

        def __repr__(self):
            return '<flat_cstore_ssd (pk={0}, file={1})'.format(self.pk, self.file_pk)


#q=session.query(c.pk, c.file_pk, dapdb.File.pk, dapdb.File.filename).filter(c.file_pk==dapdb.File.pk)

#C5Cstore.file = relationship(dapdb.File, primaryjoin=dapdb.File.pk==C5Cstore.file_pk)

#'c5_cx', 'c5_ssd', 'c5_cx_ssd', 'c5_cstore', 'c5_cstore_ssd'
#'flattabletest', 'flat_ssd', 'flat_cstore', 'flat_cstore_ssd'
    




