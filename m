Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E715210112B
	for <lists+cgroups@lfdr.de>; Tue, 19 Nov 2019 03:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKSCQo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Nov 2019 21:16:44 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50598 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfKSCQo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 Nov 2019 21:16:44 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ29DRf193330;
        Tue, 19 Nov 2019 02:13:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=0HzX/gxMttS4J+L6PBkjiqoj8SSAB9SSaypPZSiCkzg=;
 b=D9joND5QO8S0RfNgqFdUhAAiwvaLvkWQx8NA14Soj4ETkg9FcnCwlVFZoVYb0oNDzxfj
 e6xJ8dl6KGgiLyKLxboS5iS8+D3IK57Jbdd27Yi7AfaZskW+fbnvRJtvdTcmtJbNfhKr
 QGG5Lh1c/gg2PFM7SGV68PypYf6afXGsyCqTubkd7KoV5b4ba/D7GvECWKV53hAQpMEE
 yQPFNyn1voCxZ+OpwT2ImC6E77fNFQOItE/CQz8DbMWkD/aDPzxIDJANWgacRtvs6PyU
 dCO9yHc16O1R2RItBSZe4NUpy/j9AyvJBFZ/ExZ3xx1P2RIyAa+gdzDsrEp/f0neprxD fw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2wa8htm0g4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 02:13:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAJ28U2E134789;
        Tue, 19 Nov 2019 02:11:17 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2wc09wjkh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Nov 2019 02:11:17 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAJ2Aw1H029693;
        Tue, 19 Nov 2019 02:10:58 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 18:10:57 -0800
Date:   Mon, 18 Nov 2019 21:10:58 -0500
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, Qian Cai <cai@lca.pw>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        swkhack <swkhack@gmail.com>,
        "Potyra, Stefan" <Stefan.Potyra@elektrobit.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Colin Ian King <colin.king@canonical.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v3 3/7] mm/lru: replace pgdat lru_lock with lruvec lock
Message-ID: <20191119021058.auxc6g7vmgf7d5gg@ca-dmjordan1.us.oracle.com>
References: <1573874106-23802-1-git-send-email-alex.shi@linux.alibaba.com>
 <1573874106-23802-4-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573874106-23802-4-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=575
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911190017
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=644 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911190017
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Nov 16, 2019 at 11:15:02AM +0800, Alex Shi wrote:
> @@ -192,26 +190,17 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
>  	void *arg)
>  {
>  	int i;
> -	struct pglist_data *pgdat = NULL;
> -	struct lruvec *lruvec;
> -	unsigned long flags = 0;
> +	struct lruvec *lruvec = NULL;
>  
>  	for (i = 0; i < pagevec_count(pvec); i++) {
>  		struct page *page = pvec->pages[i];
> -		struct pglist_data *pagepgdat = page_pgdat(page);
>  
> -		if (pagepgdat != pgdat) {
> -			if (pgdat)
> -				spin_unlock_irqrestore(&pgdat->lru_lock, flags);
> -			pgdat = pagepgdat;
> -			spin_lock_irqsave(&pgdat->lru_lock, flags);
> -		}
> +		lruvec = lock_page_lruvec_irqsave(page, page_pgdat(page));
>  
> -		lruvec = mem_cgroup_page_lruvec(page, pgdat);
>  		(*move_fn)(page, lruvec, arg);
> +		spin_unlock_irqrestore(&lruvec->lru_lock, lruvec->irqflags);
>  	}
> -	if (pgdat)
> -		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
> +
>  	release_pages(pvec->pages, pvec->nr);
>  	pagevec_reinit(pvec);
>  }

Why can't you keep the locking pattern where we only drop and reacquire if the
lruvec changes?  It'd save a lot of locks and unlocks if most pages were from
the same memcg and node, or the memory controller were unused.


Thanks for running the -readtwice benchmark, by the way.
