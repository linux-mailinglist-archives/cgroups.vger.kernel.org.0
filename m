Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1447054E191
	for <lists+cgroups@lfdr.de>; Thu, 16 Jun 2022 15:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbiFPNNh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Jun 2022 09:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376906AbiFPNNd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 Jun 2022 09:13:33 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938352DAA3;
        Thu, 16 Jun 2022 06:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655385212; x=1686921212;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=g4hwdW93fGoTn7LgrmQ5ZdqeG0AbiIa9tqo2kkr2L28=;
  b=ywduekpZNitFFHDaSdnD6rtHppOJeLe1jKlXzU5OQzBFyPPt65vOeO6t
   jJu+RAiUqw0uHXFErlC64RzgOo/SxaRMcinlqmR0sKSXs2dtq7uAG4pYK
   TqmZuThZfD7gyO+0173CtUVWESk1ZaaQmSmvkl0LY17Ef0LC3mRrBGlRQ
   0=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 16 Jun 2022 06:13:32 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 06:13:32 -0700
Received: from [10.216.41.43] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.47.97.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 16 Jun
 2022 06:13:29 -0700
Message-ID: <b4393af3-d2ec-85b5-4be8-d5abd8847499@quicinc.com>
Date:   Thu, 16 Jun 2022 18:43:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] cgroup.c: add helper __cset_cgroup_from_root to cleanup
 duplicated codes
Content-Language: en-US
To:     Lin Feng <linf@wangsu.com>, <tj@kernel.org>,
        <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>
CC:     <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220616103830.197458-1-linf@wangsu.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20220616103830.197458-1-linf@wangsu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.47.97.222)
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

On 6/16/2022 4:08 PM, Lin Feng wrote:
> No funtionality change, but save us some lines.
> 
> Signed-off-by: Lin Feng <linf@wangsu.com>
> ---
>   kernel/cgroup/cgroup.c | 58 ++++++++++++++++++++----------------------
>   1 file changed, 27 insertions(+), 31 deletions(-)
> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 1779ccddb734..a8a46eb66f21 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -1376,6 +1376,31 @@ static void cgroup_destroy_root(struct cgroup_root *root)
>   	cgroup_free_root(root);
>   }
>   
> +static inline struct cgroup *__cset_cgroup_from_root(struct css_set *cset,
> +					    struct cgroup_root *root)
> +{
> +	struct cgroup *res_cgroup = NULL;
> +
> +	if (cset == &init_css_set) {
> +		res_cgroup = &root->cgrp;
> +	} else if (root == &cgrp_dfl_root) {
> +		res_cgroup = cset->dfl_cgrp;
> +	} else {
> +		struct cgrp_cset_link *link;
> +
> +		list_for_each_entry(link, &cset->cgrp_links, cgrp_link) {
> +			struct cgroup *c = link->cgrp;
> +
> +			if (c->root == root) {
> +				res_cgroup = c;
> +				break;
> +			}
> +		}
> +	}
> +
> +	return res_cgroup;
> +}
> +
>   /*
>    * look up cgroup associated with current task's cgroup namespace on the
>    * specified hierarchy
> @@ -1391,22 +1416,8 @@ current_cgns_cgroup_from_root(struct cgroup_root *root)
>   	rcu_read_lock();
>   
>   	cset = current->nsproxy->cgroup_ns->root_cset;
> -	if (cset == &init_css_set) {
> -		res = &root->cgrp;
> -	} else if (root == &cgrp_dfl_root) {
> -		res = cset->dfl_cgrp;
> -	} else {
> -		struct cgrp_cset_link *link;
> -
> -		list_for_each_entry(link, &cset->cgrp_links, cgrp_link) {
> -			struct cgroup *c = link->cgrp;
> +	res = __cset_cgroup_from_root(cset, root);
>   
> -			if (c->root == root) {
> -				res = c;
> -				break;
> -			}
> -		}
> -	}
>   	rcu_read_unlock();
>   
>   	BUG_ON(!res);
> @@ -1422,22 +1433,7 @@ static struct cgroup *cset_cgroup_from_root(struct css_set *cset,
>   	lockdep_assert_held(&cgroup_mutex);
>   	lockdep_assert_held(&css_set_lock);
>   
> -	if (cset == &init_css_set) {
> -		res = &root->cgrp;
> -	} else if (root == &cgrp_dfl_root) {
> -		res = cset->dfl_cgrp;
> -	} else {
> -		struct cgrp_cset_link *link;
> -
> -		list_for_each_entry(link, &cset->cgrp_links, cgrp_link) {
> -			struct cgroup *c = link->cgrp;
> -
> -			if (c->root == root) {
> -				res = c;
> -				break;
> -			}
> -		}
> -	}
> +	res = __cset_cgroup_from_root(cset, root);
>   
>   	BUG_ON(!res);
>   	return res;


Thanks for the patch
Liked the idea.

Acked-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh
