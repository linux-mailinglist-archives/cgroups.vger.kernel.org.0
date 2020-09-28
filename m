Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3261727B126
	for <lists+cgroups@lfdr.de>; Mon, 28 Sep 2020 17:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgI1Prn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Sep 2020 11:47:43 -0400
Received: from sonic304-20.consmr.mail.sg3.yahoo.com ([106.10.242.210]:45948
        "EHLO sonic304-20.consmr.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726325AbgI1Prn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Sep 2020 11:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1601308061; bh=k6qD474V9VtXKDobcCBmjOJywgarZvgPlTt0r+34qBY=; h=Date:From:Reply-To:Subject:References:From:Subject; b=W0PhrjGYOJCjjHK+tTFAxG5x4yj3pHoZbkOaf7zPitcaaXVYAcq8JLXDvqwzOHdTAPMFW2kJdgjK7XZlsx2fKXgdahsJ4zBffdnOilobA54UT+QiccKRf2pUK6h7mYEoDA5pC6NvTG7PkY1wKNfO5yIfsWd/O2BOw5KGZMSQZ6i3QhAm2s/cumccKIWdlfCL1OEVORlUFU3gyZfCoGyJ0nlT4FP3mbyuvE0m1aYjz+rVQL3dRP7WOGtDlRAMK6FsbKoiA2r5yOlO3dzkxfkOvnOotJXVt2zXynPirm06gdUDj0+BZkGzoDF+w5wNdN/NEhuHXR7zMxGGy3tkzRQ4Ig==
X-YMail-OSG: dRKJmAcVM1mUHfP7WGirXZQbrNl.S2NHrEkflsMCO.8jyRSu3eA9OYCNg2ZgwE.
 jAj3WvhOUszmjGrKf.q.LVGHDt5rnbIS94DD5avSTG.55y5n3CdhEebZE7V_1bBfy5rQvBP062Nj
 K3v9VPcucR_MSiJo_SVJjDoRC2bODgRhQamRNSNtrfzrEJ0grb1kQCnnfkgy4N8CiI4VEKySqjdz
 Z69WUoH.Mc32b9Nguj.z6P1zibwHefwDcGXCJYb8lIRCMMnDWfMgGNtIFI0pVrBaKwNK048MAyPI
 jwl7p6DCuZsh9rWaDeqLc0mZaIU8ZKcQd4S_TWPflcZOwxISzu_vUkzgwYcgYWp.w9nuRh.HMT6R
 VhOsvZO6XZvOei5R4IsZ5xgie3Yko7nXmpN1nS1GN7UaJD6AlqYFPI9zvh6qFGSLQuXv4nD65gGK
 BdecE0ss70KTdnLXaMluiy_t6mJbyNBMzqaZLw7Pc26Gaht6ua9WbgDLcc9hnG677QaydG4xQbL3
 AU1LeNPdtRNkliJ4JPJ6.iDC63sq1USxxhsBmGkAisdRw75Gfg4E8ODe2SyV5JT25DxdffeQKUJg
 DWQs2_K7ipWPWkimaTXr6U5.9lBM3sayjzbRKMK5OvRofoWOpGGoZ6quKEkmcb0VPQevzLA31Af.
 YWxi1IDql4SI22GWJfA3Rw8MVTfQElNJblivYtEBx755Tv17JSRlSx898wImpQBonsuQ3uzwdLqh
 EU1_xEHPUsqKFHHEM.osfltRc2ApEcttY59tzUf_GcJ.HVJbfyfW3eoR6RYc9iT03R706rrHGjgD
 QyeT9ofOaYREgzHAI.G3ARqit4fD4pHQUAm7NYs40P6BoCUuXwLQ1Mm9BKrYFuhAgOZT0ppc9JkN
 iGV_275ux5Ckiei7lbBTmEELJ5_1XsPrC6g5rqOSZBu8I68jpUoAaL_S1nkLAOICdvJJqpZucgwC
 tlVWiTiS0SW3J7KtQr3HMbyfUVMqbmOrAsM6TWsT4sTciHpUd3qxmzbpIiR8yqUkvUsRM5WuveJn
 1uDYS5CbweG05A1rCg20XESPxHWEWQNHSx._yfLll3zZyyrdq1qNsHo3odQ.dtstPKsbfeKyv1pU
 9bkBzLdAPMWapyqY8E6qREkLDt8FOiz1rFShzEi6ZT7azs0sDa.Xs0RqaN91nhF6FS60V_LOlbKi
 5tmbqZ1JcfOX06PA36Xq2UHWtTucFKdw4yY_aUGfUzJyuOJ9uRfDo4TnR.NrzfPFCGS.0y0DJLXY
 T7wRbbb7o_9dHeU5hiI9oJoOHzLdH68RR2fvB1G9Mf2ievnYPcUCWmWHlk7vFsFvBLznulC1Yj7g
 ySCjPkL3QlgC1x_y_NB_jQQa9yqPf3KGkGhv_bdmOfUQfuHZT4CSWTUsNLnUk1aWuQlGk.spg6ri
 FH37qJ14qE6u34F2s4AOCVN.qZT5KZZr50PIecuyOdChG3WsLj4XuLNq.Lh3_wi2II2dLdQ_S5Ks
 h6A--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.sg3.yahoo.com with HTTP; Mon, 28 Sep 2020 15:47:41 +0000
Date:   Mon, 28 Sep 2020 15:45:33 +0000 (UTC)
From:   MONICA BROWN <jjjjjjj.kkkkkkkk@aol.com>
Reply-To: jjjjjjj.kkkkkkkk@aol.com
Message-ID: <1399134900.1335060.1601307933348@mail.yahoo.com>
Subject: FROM SERGEANT MONICA BROWN
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1399134900.1335060.1601307933348.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16674 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

I am Sergeant Monica Brown, originally from Lake Jackson Texas. I have 
personally conducted a special research on the internet and came across 
your information. I am writing you this mail from US Military Base Kabul 
Afghanistan. I have a secured business proposal for you. If you are 
interested in my private email (monicabrown4098@gmail.com), please contact me 
immediately for more information.
Thank you.







