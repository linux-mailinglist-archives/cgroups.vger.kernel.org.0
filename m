Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEBC4A4CFF
	for <lists+cgroups@lfdr.de>; Mon, 31 Jan 2022 18:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380834AbiAaRTT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jan 2022 12:19:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9698 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380851AbiAaRTM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Jan 2022 12:19:12 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20VGcViZ019356;
        Mon, 31 Jan 2022 17:19:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : cc :
 subject : in-reply-to : in-reply-to : references : date : message-id :
 mime-version : content-type; s=pp1;
 bh=poY0kfQh15XSlaopeCLHDnvfnTwXN0R1WdEoLg1//UI=;
 b=totHUAPubofj9Gd2V6jJYRo46ExN8ckmGGxwgMrWTUfvO6vK9uRGr17d+0UgburzWOiM
 G+yszAeaO3Yx7rCo8NYlEVhgL90n+ufMSkKiFC8F6imMAXe9gXgtkpf3AyPuiN3jUvUh
 9CPIsjLibWGLwGyStPcDE9WS9U8yQWPOC6Icu6YTJP9+HjBNXYbMhazFJNuWvz+y48kS
 Qr/9Iz06IIcALxFGM3H4tjmubNTLbgoJT9//JuUu8+E0SodB2Em8/5EaPee7fTJFuyEZ
 Uk4mWLp9l9lrQ+pJfEc1WVzz+xIX2Nu5L9EmexLgvv8bgJYfVJUgBOsG6+7bBqUjGgYd CQ== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dx33x2r55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 17:19:08 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20VHIY4u019614;
        Mon, 31 Jan 2022 17:19:05 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 3dvw7950sx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 17:19:05 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20VH9Gl642467738
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 17:09:16 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D43211C058;
        Mon, 31 Jan 2022 17:19:03 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D04511C054;
        Mon, 31 Jan 2022 17:19:03 +0000 (GMT)
Received: from localhost (unknown [9.171.15.168])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 31 Jan 2022 17:19:03 +0000 (GMT)
From:   Alexander Egorenkov <egorenar@linux.ibm.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     cgroups@vger.kernel.org
Subject: Re: LTP test suite triggers LOCKDEP_CIRCULAR on linux-next
In-Reply-To: <YfgWAuzAo2WDyPH+@carbon.dhcp.thefacebook.com>
In-Reply-To: 
References: <87mtjzslv7.fsf@oc8242746057.ibm.com>
 <YeI78TMjU12qRmQ8@carbon.dhcp.thefacebook.com>
 <YfgWAuzAo2WDyPH+@carbon.dhcp.thefacebook.com>
Date:   Mon, 31 Jan 2022 18:19:02 +0100
Message-ID: <87r18nj01l.fsf@oc8242746057.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9XKePtBzGZ4UdLsWkmN1QgtxXiZCt_Np
X-Proofpoint-ORIG-GUID: 9XKePtBzGZ4UdLsWkmN1QgtxXiZCt_Np
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-31_07,2022-01-31_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 adultscore=0 impostorscore=0 mlxlogscore=972 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201310111
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Roman,


Roman Gushchin <guro@fb.com> writes:

> On Fri, Jan 14, 2022 at 07:13:53PM -0800, Roman Gushchin wrote:
>> On Thu, Jan 13, 2022 at 04:20:44PM +0100, Alexander Egorenkov wrote:
>> 
>> Hi Alexander!
>> 
>> Can you, please, check if the following patch is fixing the problem for you?
>> 
>> Thanks a lot in advance!
>
> Friendly ping.
>
> Thanks!

I'm very sorry for late response,
we just noticed your mails :(
We installed your patch and today's CI run will use it for testing on
s390 arch.
I will have reports tomorrow.

Thanks for prompt response!

Regards
Alex
