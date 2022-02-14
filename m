Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABBE4B560E
	for <lists+cgroups@lfdr.de>; Mon, 14 Feb 2022 17:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356323AbiBNQXW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Feb 2022 11:23:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356313AbiBNQXW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Feb 2022 11:23:22 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CBB60AAD
        for <cgroups@vger.kernel.org>; Mon, 14 Feb 2022 08:23:13 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id e16so15902123qtq.6
        for <cgroups@vger.kernel.org>; Mon, 14 Feb 2022 08:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0I6QCfcZvTXg/UIVMtXAqnAJEFMpz4YPEOXp860qAcQ=;
        b=ZbOs/VFsA0tNTT51uy23Gy4Eibq2IbTAzBHaLm6ub5lmEKlZFXUqvU9JTDKzk3L9n1
         SlkGGq23eWcOqQ7MnmhcwrgKHTmAT43k7rB0+fYs5wpr3tOjyh4rdLr27J02Z6h1UZTP
         EECDCgTpw1IXTfBNYqppgkzaJlPWtSit/JTfYIBX8GKN+tkXTSTKWm3UDU0nY7C2mt5I
         kKUbWxdIkn+2V+bt0cMnt9AcqmXYeihyeliG8h1ktTcbuswQpfMy4LLsnIjngQUaUVsZ
         xeSIHig17I34sKfSPZOGQjcoBJubENZb4SVPQHcuCT7PeouC82fdMHwPnvaRAteeHG2L
         ykXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0I6QCfcZvTXg/UIVMtXAqnAJEFMpz4YPEOXp860qAcQ=;
        b=nssC9C6eqpcYEQY/qTeqjiBw7992dSLW1zzcPevgzi4fPDqlmfG18WfvV4Ar8osrxo
         EMVUw9lP7O0lEzD2dPLtqOL2+rE9QW5S8AHnpyVvdGg/PbZ1DKDkd3gC78LJ6w8FVQwS
         YE5sfV89fD9XR36ooPIOf6oqvjFoZckC3TKkvdMgiAYCvWE3LmipzoRTdPXljhUpQiLG
         uLCoa/HQswHbEDA+1z84Txin1lib6d5pdHmXgx5wUVix7fwSPmLKAU1RkL3wBk45/ltS
         LAbeIGApMR2lgu7e8/MXYJUVXhlS8xjh+DZsjHfCma4cHxVcqzVPkCSKT52Qm5lInLpT
         idxg==
X-Gm-Message-State: AOAM533lNu3foXFEe+nFwiQ6TVwy03YnZzxcA1m0Em9AcvXYi8J98tyg
        xQODSNMF0amHNi8e7Mlu+QSxrA==
X-Google-Smtp-Source: ABdhPJyz/Mo8APKWts8w76SzPaBdPe53vN/BZGAjIhucRxc0vNPIwKXYpJJHU99IuEQYtwMaGHp2zw==
X-Received: by 2002:a05:622a:1787:: with SMTP id s7mr398070qtk.631.1644855792746;
        Mon, 14 Feb 2022 08:23:12 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id h6sm15745633qkk.14.2022.02.14.08.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 08:23:12 -0800 (PST)
Date:   Mon, 14 Feb 2022 11:23:11 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2 4/4] mm/memcg: Protect memcg_stock with a local_lock_t
Message-ID: <YgqB77SaViGRAtgt@cmpxchg.org>
References: <20220211223537.2175879-1-bigeasy@linutronix.de>
 <20220211223537.2175879-5-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211223537.2175879-5-bigeasy@linutronix.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Sebastian,

On Fri, Feb 11, 2022 at 11:35:37PM +0100, Sebastian Andrzej Siewior wrote:
> +static struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *stock)
>  {
>  	struct obj_cgroup *old = stock->cached_objcg;
>  
>  	if (!old)
> -		return;
> +		return NULL;
>  
>  	if (stock->nr_bytes) {
>  		unsigned int nr_pages = stock->nr_bytes >> PAGE_SHIFT;
>  		unsigned int nr_bytes = stock->nr_bytes & (PAGE_SIZE - 1);
>  
>  		if (nr_pages)
> -			obj_cgroup_uncharge_pages(old, nr_pages);
> +			obj_cgroup_uncharge_pages_locked(old, nr_pages);

This is a bit dubious in terms of layering. It's an objcg operation,
but what's "locked" isn't the objcg, it's the underlying stock. That
function then looks it up again, even though we have it right there.

You can open-code it and factor out the stock operation instead, and
it makes things much simpler and clearer.

I.e. something like this (untested!):

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1b3550f09335..eed6e0ff84d7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2215,6 +2215,20 @@ static void drain_local_stock(struct work_struct *dummy)
 	local_irq_restore(flags);
 }
 
+static void __refill_stock(struct memcg_stock_pcp *stock,
+			   struct mem_cgroup *memcg,
+			   unsigned int nr_pages)
+{
+	if (stock->cached != memcg) {
+		drain_stock(stock);
+		css_get(&memcg->css);
+		stock->cached = memcg;
+	}
+	stock->nr_pages += nr_pages;
+	if (stock->nr_pages > MEMCG_CHARGE_BATCH)
+		drain_stock(stock);
+}
+
 /*
  * Cache charges(val) to local per_cpu area.
  * This will be consumed by consume_stock() function, later.
@@ -2225,18 +2239,8 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	unsigned long flags;
 
 	local_irq_save(flags);
-
 	stock = this_cpu_ptr(&memcg_stock);
-	if (stock->cached != memcg) { /* reset if necessary */
-		drain_stock(stock);
-		css_get(&memcg->css);
-		stock->cached = memcg;
-	}
-	stock->nr_pages += nr_pages;
-
-	if (stock->nr_pages > MEMCG_CHARGE_BATCH)
-		drain_stock(stock);
-
+	__refill_stock(stock, memcg, nr_pages);
 	local_irq_restore(flags);
 }
 
@@ -3213,8 +3217,15 @@ static void drain_obj_stock(struct obj_stock *stock)
 		unsigned int nr_pages = stock->nr_bytes >> PAGE_SHIFT;
 		unsigned int nr_bytes = stock->nr_bytes & (PAGE_SIZE - 1);
 
-		if (nr_pages)
-			obj_cgroup_uncharge_pages(old, nr_pages);
+		/* Flush complete pages back to the page stock */
+		if (nr_pages) {
+			struct mem_cgroup *memcg;
+
+			memcg = get_mem_cgroup_from_objcg(objcg);
+			mem_cgroup_kmem_record(memcg, -nr_pages);
+			__refill_stock(stock, memcg, nr_pages);
+			css_put(&memcg->css);
+		}
 
 		/*
 		 * The leftover is flushed to the centralized per-memcg value.
