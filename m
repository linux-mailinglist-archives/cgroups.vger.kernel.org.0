Return-Path: <cgroups+bounces-7945-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 672D7AA44E8
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 10:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDC641BA00FA
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 08:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2C4213E7D;
	Wed, 30 Apr 2025 08:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nBIidhEV"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8444D213E71
	for <cgroups@vger.kernel.org>; Wed, 30 Apr 2025 08:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746000597; cv=none; b=CCMAKgLQ3lipzpxv8Z1Fq3jVhw5bZQ3J+kWy/gwhDH9e4rr4NvnjstjF6EOeQ87nhlaWbsTD7ja6DLb5BTA71jurto/+4fpzF+cbQ562OhsLYq3O+5KTsiJZiTBq80+xhIik4POL+WxIBo2UzAqZ4Z6KIlyzTU93lwgaw8Q65Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746000597; c=relaxed/simple;
	bh=V92/VPWOsqNOTJPRh0DfHBcACPxnH83qmTthFQECo8M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OxPHugEtqP2r+lZXa2HulRS7dl53VDEq0ZViyFSENfrC2t57BZ00HlTpsmMe4Awfa+7Dtt8rLZhyiFNc+j5fexInwGpmv4dPYOE7sUWqJL3ae5/wfGS1wqm+evXtxTqghH+ZQHFJJnMQB+11+FVebopL/aB+iZtsrMLSmA8flcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nBIidhEV; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39c30d9085aso5088001f8f.1
        for <cgroups@vger.kernel.org>; Wed, 30 Apr 2025 01:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746000594; x=1746605394; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=17bhJA8AZQ7Vt532tDF2LwCcxcU9MVtR3GoRV0UAhKY=;
        b=nBIidhEVyxg1czy+vE/+gXLmoY8R7RakVyYpEOiulhT9l14BLhhiJfPDfd0ANGDGWX
         xuWOzekMf/XbiA4K9B1jZ3t798S9unt2WW3jWNU2CmDLlMz4NiZGY4/UZuz5FmWPmrDh
         nc/5AOSknYh4Gvtm5lwwUiedHyqq7IbfxM4E4uJIajbH5BHu6faUQ64PFtRM3ZIb9GIt
         eQIuCLaXrox5WpjqpblKBFJAwFEbmPiZqRYupfPlzYCcn2ICJUR0tj+ZtwZeJzr/iLl5
         9rGgB7BptAv82qihkjQVKzkquQEKD8xMbl+a0DelQb1PxYd3qzeqP5dch4vcm9xIM6oR
         2uQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746000594; x=1746605394;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=17bhJA8AZQ7Vt532tDF2LwCcxcU9MVtR3GoRV0UAhKY=;
        b=cFElVmY5mfis1bg60tk9m8EcnmWPY8WqeEuNNw1zvGNTuy+O2eFh7nfge6ZIG6gaDY
         Rt36HsSlbn/Heo95qC3o+nnSI9lluaXl/84ucPZGeVm/ao4tT1FaZJAQFIMNPz6R37t3
         V8rp/JXqhqbYyQPwiTRiIo42K77s5nOvEcMbMCMr6jUVmMjmsJ0SDnzxFz8MgL0778VS
         izP5cS0oiA0Jpc27c0hegTOfsIuYSsPx9ql0fx+jOh5mLZIyizuVaXk8KzrqUgCYy4ph
         dWtUZh6sm+KpehSA8eRb2b0wtRQoC92cba5L9MjaPXE0hLNAcqL4y7D6A0lEmM9vg2ED
         jlpA==
X-Gm-Message-State: AOJu0YwviTpH36/lgKRS3hS8oLhME6/dqQKfK7rI9jL64EbRQmDdZafH
	9RWtakoaZvZ4s3EtHo9jPz0IXQZTJpDKiN8XLv68qNETOzXXjCRzX5nAx86Kh40=
X-Gm-Gg: ASbGncsQ2U9CjX4NT1C/OS1w4PWSN+1aasSbz4i6bA7wfg1Ja8nbU6dM6BQmQnd24O4
	Kezr2nIHXdZJgBXbEdvQVIqOK4GeccjWSE5rtI9Kl82MBBIsvTS/pkEAnC2mU3fNl4hLMX1hNij
	vkA5X2Kx1dbXCqTWks9oY2N4SCFhLCp5m8LaIM/L051xyqKyCiZo3TouJiR3uD5siYzyUO2TQpT
	mAROZpM3RB6UnGGUReqc5fZ+75555aVXxAwdXUgKpy32S/z++BUckByhbwQpngvDdw3IgcGRXFB
	ddpW+ajjj6hJZ772mm8PL0i0sEXA4n59c0s2elzg/VLEIw==
X-Google-Smtp-Source: AGHT+IEwMjB/zU0Nrl29aazIXZVdeChuhWRO2pXfV9OFMwJ44f5w1RUnGtR1GuBexWs2MQgVEn40jQ==
X-Received: by 2002:a5d:64c6:0:b0:390:e5c6:920 with SMTP id ffacd0b85a97d-3a08ff32fe8mr1273060f8f.3.1746000593758;
        Wed, 30 Apr 2025 01:09:53 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a073c8d495sm15920037f8f.2.2025.04.30.01.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 01:09:53 -0700 (PDT)
Date: Wed, 30 Apr 2025 11:09:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: [bug report] memcg: multi-memcg percpu charge cache - fix 2
Message-ID: <aBHazntT1ypcMPfD@stanley.mountain>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Shakeel Butt,

Commit 1db4ee9862f9 ("memcg: multi-memcg percpu charge cache - fix
2") from Apr 25, 2025 (linux-next), leads to the following Smatch
static checker warning:

	mm/memcontrol.c:1959 refill_stock()
	error: uninitialized symbol 'stock_pages'.

mm/memcontrol.c
    1907 static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
    1908 {
    1909         struct memcg_stock_pcp *stock;
    1910         struct mem_cgroup *cached;
    1911         uint8_t stock_pages;
                         ^^^^^^^^^^^

    1912         unsigned long flags;
    1913         bool success = false;
    1914         int empty_slot = -1;
    1915         int i;
    1916 
    1917         /*
    1918          * For now limit MEMCG_CHARGE_BATCH to 127 and less. In future if we
    1919          * decide to increase it more than 127 then we will need more careful
    1920          * handling of nr_pages[] in struct memcg_stock_pcp.
    1921          */
    1922         BUILD_BUG_ON(MEMCG_CHARGE_BATCH > S8_MAX);
    1923 
    1924         VM_WARN_ON_ONCE(mem_cgroup_is_root(memcg));
    1925 
    1926         if (nr_pages > MEMCG_CHARGE_BATCH ||
    1927             !local_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
    1928                 /*
    1929                  * In case of larger than batch refill or unlikely failure to
    1930                  * lock the percpu stock_lock, uncharge memcg directly.
    1931                  */
    1932                 memcg_uncharge(memcg, nr_pages);
    1933                 return;
    1934         }
    1935 
    1936         stock = this_cpu_ptr(&memcg_stock);
    1937         for (i = 0; i < NR_MEMCG_STOCK; ++i) {
    1938                 cached = READ_ONCE(stock->cached[i]);
    1939                 if (!cached && empty_slot == -1)
    1940                         empty_slot = i;
    1941                 if (memcg == READ_ONCE(stock->cached[i])) {
    1942                         stock_pages = READ_ONCE(stock->nr_pages[i]) + nr_pages;
    1943                         WRITE_ONCE(stock->nr_pages[i], stock_pages);
    1944                         if (stock_pages > MEMCG_CHARGE_BATCH)
    1945                                 drain_stock(stock, i);
    1946                         success = true;
                                 ^^^^^^^^^^^^^^
When stock_pages is initialized then success is true.

    1947                         break;
    1948                 }
    1949         }
    1950 
    1951         if (!success) {
                     ^^^^^^^^
success is false.

    1952                 i = empty_slot;
    1953                 if (i == -1) {
    1954                         i = get_random_u32_below(NR_MEMCG_STOCK);
    1955                         drain_stock(stock, i);
    1956                 }
    1957                 css_get(&memcg->css);
    1958                 WRITE_ONCE(stock->cached[i], memcg);
--> 1959                 WRITE_ONCE(stock->nr_pages[i], stock_pages);
                                                        ^^^^^^^^^^^
This is always uninitialized at this point.  Probably on your test system
you are automatically initializing stack variables to zero.

    1960         }
    1961 
    1962         local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
    1963 }

regards,
dan carpenter

