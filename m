Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8452A34015F
	for <lists+cgroups@lfdr.de>; Thu, 18 Mar 2021 09:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhCRIz6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 18 Mar 2021 04:55:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7584 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229624AbhCRIz2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 18 Mar 2021 04:55:28 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12I8Y9VS030972;
        Thu, 18 Mar 2021 04:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=VVNmZbk4kEKIQ3os1j6YSdx22LOXyL+oojaGnuH+qVM=;
 b=TDyTFK/pxjAR41porRQsm58N1wJVCPDZNuNkvRfSdGbtGnQobNAeIDv9lab2od//II0V
 Gb9L7mjsEWPR9YDBMXYlXyyBqhT6/tjlzdleSvtOB+OLdpHMr46C7ko/sTQigwVnPaGc
 XnUfAIyhP5g2R3RaHYvry6MODB32dZzh2L2CEgI0QuRIzTeKdnpl5lXZrACn53VV2W52
 mNJHbV+qV5kv10e6t9DoiHdTAjlSBtxHPD7wZmgKueJQMAYk9E0Gg0LIqk6y+WOP20aB
 F2kdTR1GCTHeHEehOqF8c6lsCcTVN+2+xuI9e9VMOnrMgMr8Xwz9fGLy5PbrTNnacJIf sA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37c301sbt1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Mar 2021 04:55:21 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12I8YCNc031332;
        Thu, 18 Mar 2021 04:55:20 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37c301sbsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Mar 2021 04:55:20 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12I8l96w030015;
        Thu, 18 Mar 2021 08:55:18 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 378n18mk1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Mar 2021 08:55:18 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12I8tGKK25624982
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Mar 2021 08:55:16 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D723A4064;
        Thu, 18 Mar 2021 08:55:16 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8785A405B;
        Thu, 18 Mar 2021 08:55:15 +0000 (GMT)
Received: from osiris (unknown [9.171.13.96])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 18 Mar 2021 08:55:15 +0000 (GMT)
Date:   Thu, 18 Mar 2021 09:55:14 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: set page->private before calling swap_readpage
Message-ID: <YFMVcmRAnOwsYHRt@osiris>
References: <20210318015959.2986837-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318015959.2986837-1-shakeelb@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-18_02:2021-03-17,2021-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 clxscore=1011 mlxlogscore=988 impostorscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103180064
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 17, 2021 at 06:59:59PM -0700, Shakeel Butt wrote:
> The function swap_readpage() (and other functions it call) extracts swap
> entry from page->private. However for SWP_SYNCHRONOUS_IO, the kernel
> skips the swapcache and thus we need to manually set the page->private
> with the swap entry before calling swap_readpage().
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Reported-by: Heiko Carstens <hca@linux.ibm.com>
> ---
> 
> Andrew, please squash this into "memcg: charge before adding to
> swapcache on swapin" patch.
> 
>  mm/memory.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index aefd158ae1ea..b6f3410b5902 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3324,7 +3324,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  					workingset_refault(page, shadow);
>  
>  				lru_cache_add(page);
> +
> +				/* To provide entry to swap_readpage() */
> +				set_page_private(page, entry.val);
>  				swap_readpage(page, true);
> +				set_page_private(page, 0);

Yes, this seems to fix it. Thanks a lot!

Tested-by: Heiko Carstens <hca@linux.ibm.com>
