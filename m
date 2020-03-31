Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14526199142
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2020 11:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbgCaJSd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 Mar 2020 05:18:33 -0400
Received: from sonic314-21.consmr.mail.sg3.yahoo.com ([106.10.240.145]:39255
        "EHLO sonic314-21.consmr.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732106AbgCaJSc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 Mar 2020 05:18:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1585646310; bh=cV4WQyJIVteG6N1hIBn6LCThSrej1qMUlL/oqgsjG1I=; h=Date:From:Reply-To:Subject:References:From:Subject; b=SzzROYgKgpSUN5aKze07MKoPOB5ANM7UmTkZgrxTvyfywKNSo6ZBRjptqgHP51x/kR4XPEMSeVOXJHVsj6Zl1A7yRr6jpem1A53h2O3/NL01m07p3AU+5o/wvi9ZbLUfOOetnhNxXyQGqAMxWUkI2pN2sYEXw6VviLLLJ/cVqqjunWOa5uQSs12s3PhiGJ5JmgmsT4Q95SYXGI5k8jgpNPvjmNkgA78iUX0MdxY0C7Iga2TPi/hEtYkaDT9cgr+Jksa61Z/1VrrHe/ppIStVoMeWNT6dRfEPbPuQ7ns1PYRhecPB1UuwrvuZdj/J4GSLWy9p9vg2gpPw0OXBC556gA==
X-YMail-OSG: _cMhS28VM1kL_y54h7Iaw3i.TBVquha9V_QhlNN7HYbxgq.bk7B_oOzLASluaSA
 ZJ4wlMmwf2Osz1Mp2vJz.1SEY2dlS.JHcHsCJ8ekk.aSQYY8xq0FBak_nbl9D5nLnzUW8CRN9awH
 LsfhDEk5fCcJ3Rq5vNyVkBtiJGFOB0BGpuGRSntyE_LjI26bbMM9jQ3cA7oIFb49kzw7A8QqxJ.1
 cC7ZQcNrMpvA_9dIrqSIFudw3yBaSpDgHRK8NYnCz2BcFNzwdHlpVhJkQh9Md87uDMcdGXxWoe5x
 epjczsGFciAV5KQDV3EVnQ5csCEhbAYG86rW6Kn4p03O_Yq.2kM_KFTiGOPf04JIKbi2dDhB4RAa
 43Q8QQVA1V2jM9XFGseDLsgjPa.qvKiokAx447HaSau0nCG64QivZywq.dnkklg27.d1VjA8KVAV
 aLXi2NJsTRugkESstT3wxGzww7wCzomugE01QSs6pt0VeVg_ByoxWvmq4kBG3KcR3.qGvyTtd4HS
 U6cdJpCwXv0x6TiO1LDEsw82ZQybkKU9GXg0eebqv8CCFDwt8wkTkU2al2iFw4F1rENVHqOMMNhy
 j9Kvx9VVG_I2gmSSk4q6aiBna6SYZvO5PlGSJj0UQaYSq0eFU68tUr3KdsMTebT.GQ2_w5qwrYbE
 .kd9Ztp5hH87b7n5AcYcHPuqjB_CfsFyDwfgqKVUdRTAsFu4n0OR3zN4HrxvpFlKdjANRRkDEAVD
 CBjdMkIpewZPixSXrkyFmIQZ9Ipz17ZUA3rJq7B8i04AXlVpnFxVPyJv0lyu_Omuhbapmw0A6EzW
 V44PnUg.vuKdnStyyYxp2.fpYbellAZDefdEK7ebZc2r43DK27KuUGs7owzHJjLf9F80T0pGqwjl
 nEFv1gX7fmW.Cglau7lzoRYTVWgaVixiDYX.E8fv9B4ictqq55UYG2FNHLcZpl242wDvgmrW2gnS
 1Zii2KpZ_OG5han1uNaCIRn1.HdFC1AM3roygDaGxsq6sX1TpY26ADW_0uuWUhczxNOMzV5BS6JY
 NkEvZjytyxAYzXVsGRCbim5p.bx1GyHXeMYtOBBg5UUcLoHbnRAWGsqPf3DqL3cGpmAXMVIUrSNO
 Tm8eXW1f8vNlwDfD2nxcqgtehpAieaq8Op4eZKBhw6FSFOA7FRzascPWU0PSuTB1_yKw5qFwO4uG
 bLhWSlELOhs3ER07794PJiKP2lBnUy9t2qb0YOnbfPurHdJ3lz187bvs3ToQh7ZSYwN8We2diqiI
 z.YLOkOgBKINJ4CQMQZc29_ROxy37.eW9MqkKlKR0MJTD0kSlYesWM4pp4kgtRpcxRfGbQ5qz
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.sg3.yahoo.com with HTTP; Tue, 31 Mar 2020 09:18:30 +0000
Date:   Tue, 31 Mar 2020 09:18:26 +0000 (UTC)
From:   "Ms. Jane Salim" <r35753624@gmail.com>
Reply-To: jane.salim@aol.com
Message-ID: <1585962543.972258.1585646306391@mail.yahoo.com>
Subject:   HELLO, I read about you from a reliable web site and I would love
 to invest some money in your country under your care. Pls reply with your
 private Email address so that I will give you further details and tell you
 about myself.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1585962543.972258.1585646306391.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15555 YMailNodin Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:71.0) Gecko/20100101 Firefox/71.0
To:     unlisted-recipients:; (no To-header on input)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



HELLO,
I read about you from a reliable web site and I would love to invest some money in your country under your care. Pls reply with your private Email address so that I will give you further details and tell you about myself.

Yours Sincerely
Ms. Jane Salim
