package com.example.library.mapper;

import com.example.library.domain.Book;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

public interface BookMapper {
    @Insert("INSERT INTO BookInfo(ISBN,BookName) VALUES(#{},'admin')")
    int saveBook(@Param("isbn") String isbn, @Param("bookname") String bookname);

    @Select("SELECT ISBN,BookName FROM BookInfo WHERE ISBN=#{isbn}")
    Book selectBook(@Param("isbn") String isbn);
}
