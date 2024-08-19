Return-Path: <cgroups+bounces-4357-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BCA957710
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2024 00:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F4551C22E06
	for <lists+cgroups@lfdr.de>; Mon, 19 Aug 2024 22:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7362C15A84A;
	Mon, 19 Aug 2024 22:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcbFbqan"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED83914D70E;
	Mon, 19 Aug 2024 22:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724104870; cv=none; b=RPsePKZ6JCkEP7GS58xQgxrTK0o5fLS+8vajD/3XBDZ+GX8X88OpN8EDAsLs+pdDKqtxibvCp5ymkMygrucBoCM/y62X0Wkvybml0B4JcpiDmnqdIelTxciPgEyILDDQBecPllJSwndO9QwSmcIZjIRyFEqRMlFlZufv1n7krLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724104870; c=relaxed/simple;
	bh=kh1P3IOKB1fvoFeHsAMXFzvUeS7fQqodyA9v5nmkXaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4EUPdHnmEON+zHxtE8kgMa/ok74auk0fETmJWCdc4hsFZX3+Yl5yntKJ0CpLOG+Cze/SfUvrUrx9nhGW79gftPjf79wRoVFzycy2HS2QdWuCRB7Sx7DyDC/lX6LgYux7wA/b1FHYAvFw7NbcfO40njypjcvwIVRqpn3UcZzjU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcbFbqan; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7c3e1081804so3155689a12.3;
        Mon, 19 Aug 2024 15:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724104868; x=1724709668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rd77oQuask5wrbVuQZFRvahGpdDv0UVwZhhqLnU7UEA=;
        b=WcbFbqankryyYo1bYmukzfMJVHdijM+JKNxa3r23RAlcwbkKIqQrESGcihCOR6SU5V
         LgMLGZfANvJulRdAz+wBEdxvRjDBOu9/OrqM/LWgWCVRa6KdG4+RhjatRen1FInQqPKR
         DsTj1bftjyc/7FS6VEJopWo2WTz5S1M5PQoSmWUFVc1DDDjenBbOPVfnJDfn84Xk4kC+
         t+4tNlJWLbIj7ALIjWWsVuwvix0aqNRrb6SURKpvdeS2ph35h6Y2FmZi1O3ajJpOb1EC
         jb33ybwdVwrj+VWNDT6vlbWGGccqoYl1WoK9Iw/1Y94/nUpvf4DrmT/RngzIVQVJiqjd
         L4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724104868; x=1724709668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rd77oQuask5wrbVuQZFRvahGpdDv0UVwZhhqLnU7UEA=;
        b=BmVwuWDIZ74Xchj6GsZlWU0Y2l7fwMGbE7nbe26NPfHBJ3BpuftBEsj1b3gLzjI2sc
         JKY9DB6FhInJtc75YGEkv780Xwin54fcfa3cclAmnNLL3euIMDygTTppwcxxCyTed18O
         fEf5+yAyz4BDGpEWJRve+wcyHYToYYwTJRnbvlrQ3uB5gNS1NpcXSq5UL9Se7BLhpIBi
         nEJBoZLYNgDKCce4DlmQ1hNoTrVUOae2t2mKXaY/cn4HGr2Oc/nuemGQ2ap9pEfZdSsy
         GaTmUmx8UTHhF4V0rrHPKDE+dAvcw/RUBwlLUcIItW5zi0Q8atJMLCpxw8PEZKEhHeUV
         bLew==
X-Forwarded-Encrypted: i=1; AJvYcCWV8p0k1tyTmg5ghBC89wCsVvlV+oS5qH3tVBl9/3K4i4ydEbjd6wx3mOVXFyXa/zsqvN87nk1Jnu0TER2HIAHYEAjxAZRIMafNEXkQbIBoscp3GkU+qn1GqjRFgkEiHEuib25ALQ==
X-Gm-Message-State: AOJu0Yx1/LlYo4GnZuoz6Q814IjRzEfd9p40fuqY9MM/qSR1dM9RLOKA
	WiMxIGE4sKZ0sN/Fs9U4CfODoQ37NVewRpYGL5xyvij3ophSA6KgYZxT3A==
X-Google-Smtp-Source: AGHT+IHyy5H0Z1NaGSTMfqUa6JCpEanX40AkmEO86X5SbIZkOLKzl1a8BRRnDQEKdGBT4QWxMdJGAQ==
X-Received: by 2002:a05:6300:4043:b0:1c6:fb2a:4696 with SMTP id adf61e73a8af0-1c904f98efamr10926814637.19.1724104867957;
        Mon, 19 Aug 2024 15:01:07 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae08027sm7024738b3a.66.2024.08.19.15.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 15:01:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 19 Aug 2024 12:01:05 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huawei.com>
Cc: lizefan.x@bytedance.com, hannes@cmpxchg.org, longman@redhat.com,
	adityakali@google.com, sergeh@kernel.org, mkoutny@suse.com,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 0/3] Some optimizations about cpuset
Message-ID: <ZsPAoWyPpC4XdTn0@slm.duckdns.org>
References: <20240816082727.2779-1-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816082727.2779-1-chenridong@huawei.com>

On Fri, Aug 16, 2024 at 08:27:24AM +0000, Chen Ridong wrote:
> Chen Ridong (3):
>   cgroup/cpuset: Correct invalid remote parition prs
>   cgroup/cpuset: remove fetch_xcpus
>   cgroup/cpuset: remove use_parent_ecpus of cpuset

Looks like the first patch needs update. I'll wait for the v2 patchset.

Thanks.

-- 
tejun

