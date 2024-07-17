Return-Path: <cgroups+bounces-3743-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EB5934189
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 19:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3302C1C213A6
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 17:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5631822D8;
	Wed, 17 Jul 2024 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lp0KYXBL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80241469D;
	Wed, 17 Jul 2024 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721238011; cv=none; b=tfoNSsShW4JsMBhBhqzs9OHby0Nm5bRhB4QDJJp8121rKVeThACfZNs74XrCsP/Lpa4Gj2IqlKEJupZkMtmk0BjoQhlFgVxMTsTsR+g9qV7MIp1UtzLkqPGo9VMuLiTzfAty67LVXlot+Jv4n+JAKVBl1RHN+pRguS2W11i+HNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721238011; c=relaxed/simple;
	bh=Um/P8+8rNPu7oleTQ9OVw4Qg9hZm+/uLMGYljBLUuNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8LmN58QWgzTUA7oZS8EsGfVcg9TCWi40TluYgrEJbYbOJbYQhwjRA/O+M77QDGNgYqAI5rNoZizl431n1AQ22+NUjqms/cuQvCExQcG4w/TK8U/Y1wJwS9EcdJk8LzONYl1Xn7PfEvnFK7MEYkvyEppt7R9dyN1zZj0ca09O8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lp0KYXBL; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-70448cae1e0so289712a34.3;
        Wed, 17 Jul 2024 10:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721238008; x=1721842808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g2JQbY7PsSahjVcQbjA5G1MLjb4KOC10oukwY/xrmhg=;
        b=Lp0KYXBLDZiR4R03hljkBpEkBuJ+0Jjd8lCjxV95zxjeOwVlQuHc2zmkuTKnFS8EFs
         H1r8f4KSpYdVryPpmryTvZBBqoSS7tz/Vn8ApwjPkBGI2YJk/Mc+PBazOhxuA6t7hy/S
         BA/dCG4kXdKhicXkcQe5SJLceZbsL4dx3kmpviEs/JF3WOa/GcQCHk4vhqjUGXkYpkDd
         4RwD9SBb3lsqUW2FsdsUCYWSkUVnL7tS+haCCvSQAqNTT6RrUfClm0DkCVYUGA+eyxJt
         71DMZcbywMzA+u030ed5pdmOZyYgg6QcxSL6F9G1rhGLS5HruCgTmZ5I9v9lRq+yXcgH
         Q/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721238008; x=1721842808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2JQbY7PsSahjVcQbjA5G1MLjb4KOC10oukwY/xrmhg=;
        b=L0am4Fbs3sWBkLpW+0oy0H2XV+Ht19FnHzKe61VYIBICxIHAf/Zi2NPOgBKnbuUad3
         9kaHfl2G5AVjjMKXZ/z4UbjoiLgmfysrIR719UThvLGrRmh3qrNd6ZBwrCFjm+q7zhPv
         tFR0UXYCmMXRqJabnjbqyA+nbjnT8iT3ACrYIlfw8njh2H5eWPfvOQKE6Aj8R940/R8v
         7L0tpMJ0dnrAI2r3cDU2xZLelis3NGrDl4pZkbU4soJa8R7ipsLq73N6O9GFDKAh1/yW
         1FLGKUqUcZyj/PlRWhffApwGYX+Twa2KYQ4F7bfr9WIH1jpW3En316fCL4NdhgF8JRrt
         nSNw==
X-Forwarded-Encrypted: i=1; AJvYcCVnWPA+v9QtTDeqW4o7QkKtivJhy31hKJBJ1qYhyFQirR81Zn2KbI7bibl5xfL99d2Db6InDdfMVnpHQrI9vHNlw4pQp+aMWilUlnLtxcODglAIsUYFA+fDwDMOxO6ZJ3w4xVdGxjaX7TwKnknHmSCrhptseXoQznpGrn6pLQh0qkHG
X-Gm-Message-State: AOJu0Yy7dVEcf9i+B0WdXVoQBRC1QnrrmAXiFybRUOofTc4LesTZws6p
	uTtnAbQxib4Nzadvr7PN87gO+4hUHag6lNBxu8XpoyfGCMJ5HsS/
X-Google-Smtp-Source: AGHT+IFkKZ6cesFsV43HG1DzUL/qwe8kHhOrrOef3v21fl3azGhUoimP4PYwyLrhqiMFCkjOYt1Sig==
X-Received: by 2002:a9d:7ac6:0:b0:703:5c3e:88ff with SMTP id 46e09a7af769-708e37f5ae0mr2401403a34.22.1721238008578;
        Wed, 17 Jul 2024 10:40:08 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eb9e285sm8421878b3a.8.2024.07.17.10.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 10:40:08 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 17 Jul 2024 07:40:06 -1000
From: "tj@kernel.org" <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Boy Wu =?utf-8?B?KOWQs+WLg+iqvCk=?= <Boy.Wu@mediatek.com>,
	"boris@bur.io" <boris@bur.io>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	Iverlin Wang =?utf-8?B?KOeOi+iLs+mclik=?= <Iverlin.Wang@mediatek.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v3] blk-cgroup: Replace u64 sync with spinlock for iostat
 update
Message-ID: <ZpgB9kCAxAAXAtSi@slm.duckdns.org>
References: <20240716075206.23121-1-boy.wu@mediatek.com>
 <Zpbify32lel9J-5I@slm.duckdns.org>
 <c5bcbcbaeacdb805adc75c26f92ec69f26ad7706.camel@mediatek.com>
 <5560c690cc6de67139a9b2e45c7a11938b70fc58.camel@mediatek.com>
 <1b19b68adb34410bf6dc8fd3f50e4b82c1a014e4.camel@mediatek.com>
 <Zpf3ks2drDZ7ULTa@slm.duckdns.org>
 <f448f66b-7a91-4281-8f77-159541cbacff@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f448f66b-7a91-4281-8f77-159541cbacff@redhat.com>

Hello, Waiman.

On Wed, Jul 17, 2024 at 01:37:56PM -0400, Waiman Long wrote:
> bis->sync is still being used in blk_cgroup_bio_start(). Replacing it with a
> global lock may kill performance. We may have to use a per-cpu lock if we
> want to go this route of eliminating bis->sync.

So, the idea is to keep using u64_sync for blkg->iostat_cpu and use
blkg_stat_lock for blkg->iostat. The former is the only one which is updated
in hot path, right?

Thanks.

-- 
tejun

