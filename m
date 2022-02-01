Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772154A5824
	for <lists+cgroups@lfdr.de>; Tue,  1 Feb 2022 08:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiBAH5f (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Feb 2022 02:57:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2658 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229929AbiBAH5f (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Feb 2022 02:57:35 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21177vpM004925;
        Tue, 1 Feb 2022 07:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : cc :
 subject : in-reply-to : in-reply-to : references : date : message-id :
 mime-version : content-type; s=pp1;
 bh=uuxhueiyYauBBegXUW2RmKe02lmKTiZq/8hDUJP4EZY=;
 b=sSvPViUMD2obHA44CvZkGPhjj691gKY6i3MGlIHqHDqlCHTh5u1PlPeA1T0cONpKYl/Z
 mHNQNqXMQN43Vk8T0R1J9HApRBfxi6c6U6hGGH6m73TpIDuFe5uPVnkQr/pKTz7sVLKY
 gYPtiSm1cjimhWzEguWSkiVC8zGn4hdu/Ph5GllPbSWABysqXSp7RhpHvXte7HgEKtA9
 em9xATQGNwY1WNpIJEICnsAvdh0yth1KNY08CRPkMw9wg8GDGjRa/DMjCKg8oozfYbOf
 q7BIZyL1iBuCMTlkNhEoymDZEEPzd2Tkvi/dCcQJERdhMdmtcZTt4pMLQJ0R+qTHz/z7 DQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dxhm4bdqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 07:57:33 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2117qT1P026098;
        Tue, 1 Feb 2022 07:57:32 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3dvw79htju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 07:57:32 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2117vTDC42664356
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Feb 2022 07:57:29 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADD824204D;
        Tue,  1 Feb 2022 07:57:29 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E16F42049;
        Tue,  1 Feb 2022 07:57:29 +0000 (GMT)
Received: from localhost (unknown [9.171.59.74])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Feb 2022 07:57:29 +0000 (GMT)
From:   Alexander Egorenkov <egorenar@linux.ibm.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     cgroups@vger.kernel.org
Subject: Re: LTP test suite triggers LOCKDEP_CIRCULAR on linux-next
In-Reply-To: <Yfgaf885yDFPtjJH@carbon.dhcp.thefacebook.com>
In-Reply-To: 
References: <87mtjzslv7.fsf@oc8242746057.ibm.com>
 <YeI78TMjU12qRmQ8@carbon.dhcp.thefacebook.com>
 <YfgWAuzAo2WDyPH+@carbon.dhcp.thefacebook.com>
 <87r18nj01l.fsf@oc8242746057.ibm.com>
 <Yfgaf885yDFPtjJH@carbon.dhcp.thefacebook.com>
Date:   Tue, 01 Feb 2022 08:57:29 +0100
Message-ID: <87tudjow7q.fsf@oc8242746057.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bemAZ67ShBhTGeYHDVL8iTftaPQSZZ4H
X-Proofpoint-GUID: bemAZ67ShBhTGeYHDVL8iTftaPQSZZ4H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_02,2022-01-31_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 mlxlogscore=893 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010038
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Roman,

Roman Gushchin <guro@fb.com> writes:

> On Mon, Jan 31, 2022 at 06:19:02PM +0100, Alexander Egorenkov wrote:
>> Hi Roman,
>> 
>> 
>> Roman Gushchin <guro@fb.com> writes:
>> 
>> > On Fri, Jan 14, 2022 at 07:13:53PM -0800, Roman Gushchin wrote:
>> >> On Thu, Jan 13, 2022 at 04:20:44PM +0100, Alexander Egorenkov wrote:
>> >> 
>> >> Hi Alexander!
>> >> 
>> >> Can you, please, check if the following patch is fixing the problem for you?
>> >> 
>> >> Thanks a lot in advance!
>> >
>> > Friendly ping.
>> >
>> > Thanks!
>> 
>> I'm very sorry for late response,
>> we just noticed your mails :(
>> We installed your patch and today's CI run will use it for testing on
>> s390 arch.
>> I will have reports tomorrow.
>> 
>> Thanks for prompt response!
>
> Perfect, thank you so much!

i'm happy to report that the provided patch fixed the message
and our CI tests for s390 cannot reproduce the situation anymore.

Thanks!

Regards
Alex
