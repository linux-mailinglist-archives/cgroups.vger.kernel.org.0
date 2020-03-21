Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 954E518DE85
	for <lists+cgroups@lfdr.de>; Sat, 21 Mar 2020 08:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgCUHbd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 21 Mar 2020 03:31:33 -0400
Received: from sonic310-13.consmr.mail.bf2.yahoo.com ([74.6.135.123]:46725
        "EHLO sonic310-13.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727961AbgCUHbd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 21 Mar 2020 03:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1584775892; bh=NajTNMrfMLb6UXcjRhYpYerQX8PtVBLz0oFgaMINSWY=; h=Date:From:Reply-To:Subject:References:From:Subject; b=obTQG8qF6HNlu7+/kqf5ifdwdrQYpriwNBGDI8WJa9Tm3GBcg++lYF9xXgyAEnlxqDhnCeDpxVLf32r+BTqP2AalpB0KIwu+XOGK3AvmvY8XTF/Sl5wD2o4c25Oa+7gaDz1MJatYcxHhGmMW+zsDiUWiou6P30Jlq/spo94if69ScIvkGeC8hresg2SaEmHD3DtDj0H69Qg22S+PCTc3kB3qF5d4+qwidp6/ckGYgDyZzOc2TtttB86WPMMuSbNwfv6uPd+Iqk5ouQT92byIvq3BOszE8L340f4c9DLcucd7hWke7z7o8x9gBQvtEiTvizOZKE5DG81wHFBDIsf7rw==
X-YMail-OSG: ekc.G0wVM1kMZWIZ8pVshmiA3GwqVGRprnOfmf7ira6N5UGkZY4tDZ_3JlUj65B
 iof1kAqEgnLorRaJMY73oQL.zIcusquQ3fO022I5yRw.JzGc_B2aDz9YPjYfcnk_Bm9yJa2rx_EJ
 zsoiNWrsmXVfPoptwts_P6wVsPpknURCPKFCzSrGojOhjJ5fgwJNjyXv5TvGxnFsiGRXvV1M86FX
 KxWnIRUdjoQ.85nZ_ZU.jmH365xqraLQKGZl34Nmev6t_lvEQWFzndRRtsW.arleNo1LW03MBOB4
 _tg6FtVgHfKAtUCy1L2NEvWNlVMe_yar_cuumDGmEN6qUq61nUSoQisB73_0sInlF0eymGSem_t1
 uVOwEx0zmGWwk7V1L7SXL5ae1rgqUKq71Gy2EdIzHK3HVulTiUCd7n7BZ6XVYp.z_huzAqk0LS0G
 MxqK3aXDTKXuY7NJStY_AhrRnCv.klncLnUYanEVRYo6BY01u5T8RsEVn8pQSH0kANlVlRNiVC7I
 V30gL_wVJ08nZJGXVVl3rFfiKRpbtqEIyGVK6C1ePgvPwyBf5gTMejVERvWm0wFC5Kcsin4tMejt
 LkcKm55QUVysjLh_wUrOdQsGH.AKvee_8XriU3E_yjMlhamY10bwjRFcWZc5Jo89qtMpa5yonR6d
 aVy3jQ_2iaJKDmX9iIjvZN4vU0weYBgRyz5ZPmReh9RdnPGgnW4quk3bpXs3YLh7VcRZv8HB6LjL
 Jogm.8F5FsJ6bi7kbBEQYKZUFXGfl6sE10CRwuFgnVjVY7Rc2kmFaOuIGfk2AtssEgaKv7UOXZxl
 qcSIb.VEISjQA6ieUZJbTQ0v32_oq1qL1tv_pgGnwg1vMFRzFNqrd.W8.6v2._DOEvz1tCMIx6IG
 bYUz8QztXNITjf_0WrX494KYcKGW6M2AQKQ03O3Kij6.uNRjmPAblP1_UwfAzqjC9sDJlk6Y.TO.
 UELko7gK9wIXYGgiLtGTKNCRTMnez4_TFnB3cFfHOJ.BQ.1P6h2LP6LTbf64wVEEF6CFGqSOcvOf
 7h3GRejUgntvJbJzplLOb13oNVwQYdbt_vUB09_EDcFJKUVbxo2rOnkJ8mKyu6V_ppTHHVKU_Mwc
 23lJlgu7Qwe9dAlFJArZginMD7ZawMlWE2P_uqLN.ThmbTXxAYFJRaVq1T.F8l6IyQIkzGbpAPdw
 AD7l7fDpq5X8LZNydMqaCfYKRck0JE9QqO3ay_So3IZxlkkj8N0NJQDv4G4nmaVybKpft6dX4CUX
 XTyt98uvmsQ3oc9DmOwzqDoVw4_Ska5_IT4xxmQtbr6jFBL.xtvrGIojQICvKNZQVC6P4vEHWgA-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Sat, 21 Mar 2020 07:31:32 +0000
Date:   Sat, 21 Mar 2020 07:31:30 +0000 (UTC)
From:   Ms lisa Hugh <lisahugh531@gmail.com>
Reply-To: ms.lisahugh000@gmail.com
Message-ID: <1871145584.11548.1584775890875@mail.yahoo.com>
Subject: BUSINESS CO-OPERATION.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1871145584.11548.1584775890875.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15511 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:74.0) Gecko/20100101 Firefox/74.0
To:     unlisted-recipients:; (no To-header on input)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



Dear Friend,

I am Ms Lisa hugh, work with the department of Audit and accounting manager here in the Bank(B.O.A).

Please i need your assistance for the transferring of thIs fund to your bank account for both of us benefit for life time investment, amount (US$4.5M DOLLARS).

I have every inquiry details to make the bank believe you and release the fund in within 5 banking working days with your full co-operation with me for success.

Note/ 50% for you why 50% for me after success of the transfer to your bank account.

Below information is what i need from you so will can be reaching each other

1)Full name ...
2)Private telephone number...
3)Age...
4)Nationality...
5)Occupation ...


Thanks.

Ms Lisa hugh.
