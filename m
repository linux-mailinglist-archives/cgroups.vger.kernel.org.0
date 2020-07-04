Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7830321433D
	for <lists+cgroups@lfdr.de>; Sat,  4 Jul 2020 05:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgGDD3U (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Jul 2020 23:29:20 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54648 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgGDD3T (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Jul 2020 23:29:19 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0643IE0v056401;
        Sat, 4 Jul 2020 03:29:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=xICZg36pt8h/hSPa7Ni+oRU48F4QAE0rnESu93rms6E=;
 b=GaxIQ0mXCFQ9B6DI5XrlVJ4YDKWNcTEAYyAkaXWpBdBabGXejcQoYd4GKqlDXxFEsNo4
 Yo/c3Wfuq8Bw4rgxkS5QNGPANMnOo8YZnuQwi9uojng+/lIdi7QXgXeJdvJda5tvObfZ
 kj7/qfR9M8AcoqogpodLMo9sIgIlGjsaTGNcTUr/PCI8iQYD/cS/taCcIBAoH3eR/UWm
 j/VTxcPlSY7klKeppS+ktOLe3mEWoZ7UOLnwPkx3AlVQv+xpyFHkEQkOfqqwaZjIck5O
 63KkNipcYjh3ezk1M7oowSTgacTeIE9KYlijS2rkUSj6tVfB376DqN7ZNmHeLAXtfD7A dw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 322hqm00bm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 04 Jul 2020 03:29:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0643Cwiw082610;
        Sat, 4 Jul 2020 03:29:00 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 322ft93j7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 04 Jul 2020 03:29:00 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0643SocQ028543;
        Sat, 4 Jul 2020 03:28:50 GMT
Received: from localhost (/10.159.135.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 04 Jul 2020 03:28:50 +0000
Date:   Fri, 3 Jul 2020 20:28:46 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, cgroups@vger.kernel.org,
        dm-devel@redhat.com, Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 13/13] Documentation/admin-guide: xfs: drop doubled word
Message-ID: <20200704032846.GU7625@magnolia>
References: <20200704032020.21923-1-rdunlap@infradead.org>
 <20200704032020.21923-14-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200704032020.21923-14-rdunlap@infradead.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9671 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 mlxscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007040023
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9671 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 clxscore=1011
 priorityscore=1501 phishscore=0 mlxlogscore=999 cotscore=-2147483648
 bulkscore=0 malwarescore=0 spamscore=0 impostorscore=0 suspectscore=1
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007040023
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jul 03, 2020 at 08:20:20PM -0700, Randy Dunlap wrote:
> Drop the doubled word "for".
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Darrick J. Wong <darrick.wong@oracle.com>
> Cc: linux-xfs@vger.kernel.org

Looks good to me,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  Documentation/admin-guide/xfs.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20200701.orig/Documentation/admin-guide/xfs.rst
> +++ linux-next-20200701/Documentation/admin-guide/xfs.rst
> @@ -133,7 +133,7 @@ When mounting an XFS filesystem, the fol
>  	logbsize must be an integer multiple of the log
>  	stripe unit configured at **mkfs(8)** time.
>  
> -	The default value for for version 1 logs is 32768, while the
> +	The default value for version 1 logs is 32768, while the
>  	default value for version 2 logs is MAX(32768, log_sunit).
>  
>    logdev=device and rtdev=device
