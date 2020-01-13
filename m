Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD73139516
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2020 16:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgAMPm7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Jan 2020 10:42:59 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:41358 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbgAMPm7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Jan 2020 10:42:59 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00DFcw7o009205;
        Mon, 13 Jan 2020 15:41:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=DaiMzq10P7q2znpRBBajknZMYi+ZtWubzic8NGU8mfo=;
 b=sE8GHT2SDtHhjkzDOynzxChoJhv6zkVeBzHBdfCaY7p+DOvJXh69L7uo8fa07mQ/fMVr
 /miOInt1cI3EVZvZEziLjpafJrDa2xOrvUs5t+gLqTsIJ/PZVC+wb8Ip7ZV/BSb+Pzkv
 Uoihwv3ROB3y2pgzcZVXOkFpfMHJ+RfiWkfHV09AMKe45a4Wj26LQBsMJ3lY/WposRWF
 c16UC4OfUtsOIFzL4tJTnx3qBOzbirK88CUCIS6IPj2eZyUIxcuqcliUl0pg/cw8z703
 7dCQsJ9IzjpzUWP04nR9rty4p7SVtX3wqO7FXMuHQiF8WrJKW2vIgmBjte4zpRaZdNzJ 9A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2xf73tfr9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 15:41:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00DFdOHu063080;
        Mon, 13 Jan 2020 15:41:23 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2xfrghx04f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 15:41:23 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00DFf9gR030155;
        Mon, 13 Jan 2020 15:41:09 GMT
Received: from ca-dmjordan1.us.oracle.com (/10.211.9.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Jan 2020 07:41:08 -0800
Date:   Mon, 13 Jan 2020 10:41:16 -0500
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        shakeelb@google.com, hannes@cmpxchg.org,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
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
Subject: Re: [PATCH v7 03/10] mm/lru: replace pgdat lru_lock with lruvec lock
Message-ID: <20200113154116.mwly5hl5yfvjkzl2@ca-dmjordan1.us.oracle.com>
References: <1577264666-246071-1-git-send-email-alex.shi@linux.alibaba.com>
 <1577264666-246071-4-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577264666-246071-4-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9498 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=629
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001130130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9498 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=696 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001130130
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Alex,

On Wed, Dec 25, 2019 at 05:04:19PM +0800, Alex Shi wrote:
> @@ -900,6 +904,29 @@ static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page,
>  {
>  	return &pgdat->__lruvec;
>  }
> +#define lock_page_lruvec_irq(page)			\
> +({							\
> +	struct pglist_data *pgdat = page_pgdat(page);	\
> +	spin_lock_irq(&pgdat->__lruvec.lru_lock);	\
> +	&pgdat->__lruvec;				\
> +})
> +
> +#define lock_page_lruvec_irqsave(page, flagsp)			\
> +({								\
> +	struct pglist_data *pgdat = page_pgdat(page);		\
> +	spin_lock_irqsave(&pgdat->__lruvec.lru_lock, *flagsp);	\
> +	&pgdat->__lruvec;					\
> +})
> +
> +#define unlock_page_lruvec_irq(lruvec)			\
> +({							\
> +	spin_unlock_irq(&lruvec->lru_lock);		\
> +})
> +
> +#define unlock_page_lruvec_irqrestore(lruvec, flags)		\
> +({								\
> +	spin_unlock_irqrestore(&lruvec->lru_lock, flags);	\
> +})

Noticed this while testing your series.  These are safe as inline functions, so
I think you may have gotten the wrong impression when Johannes made this point:

https://lore.kernel.org/linux-mm/20191119164448.GA396644@cmpxchg.org/
