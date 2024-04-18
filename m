Return-Path: <cgroups+bounces-2592-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 662FE8A9F75
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 18:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96DDB1C20DCC
	for <lists+cgroups@lfdr.de>; Thu, 18 Apr 2024 16:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D3216F849;
	Thu, 18 Apr 2024 16:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7S51BKg"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD556A8D8;
	Thu, 18 Apr 2024 16:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456127; cv=none; b=P3zuMTJmUkf7B5UsR+YAwTJerF6Vf86GJm2mc163Fgewk57fpYJX8AkSd0fcPsAYDy3ZL9N55ubgfhZy/muLJClHNzsMt4GfPLb7rpHDHnIQXk5Yk95DaUE1PNqUsj9eAafoUCNTY+/THUCuBhDU3vpQq1MyouXysj1uWapF7/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456127; c=relaxed/simple;
	bh=8KUpwSBLxlget5PtvZUAsOas9oTtC2xvMxKRTyW06Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGuVEPlwJJfxeEy7IlmsYKC8Px60f1BviBZzOR+eHF3NZFMOB6do0wFtSCdeykACwe9f2S67h76wR5Oh2LTboCdSG51TjQT/PD9/qohN+Q84OtuuVC5L/G0QL5Xq5XF4zACbHIQmAtagXy2S1vZb8lh/ckaz7KsIU+JrhP+u5tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7S51BKg; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bbbc6b4ed1so722797b6e.2;
        Thu, 18 Apr 2024 09:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713456123; x=1714060923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WO/elFYZgNlT40KKxCde7jr2kM1DEQ177uDPBCk5F6E=;
        b=Y7S51BKgS3vHPBwwAu4caSkoXJq4YxUjoxW8/oIeAYCDjs9o3WhUd3u9X7WG8oetBe
         OzytDbGYQFyPmLbVKMR6nMqG2CMN08qlgwk0uFa2v6lpWBP2Th9bieF/UdJLvm29F6ym
         Y90bOXGG3DNi+n7L+5LNc3juYwZ5NVvG+ASMjlu1PvMyyfoyow89P7mT9y3opuk4Fhlz
         VPuYurs+bAfz10XS8bYgGxO3YaJ92nJBO/TkHsMNeiFDmcZ6I28Mshb7BPyCg3+0wpiw
         NxUwpXZ/sT2lKcyI72qSUMRIa8h32Q8KpQaDoJzUVK/N61eoocXuhwN6Vz1WHgNUVI3E
         zOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713456123; x=1714060923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WO/elFYZgNlT40KKxCde7jr2kM1DEQ177uDPBCk5F6E=;
        b=fQFeor2X2viJZIXxJLswdGKNuc27huoPI+O5YTezstatX8oV7DucBkHVZATVDQ88uN
         h3e23sN5xKeHL3d4oiIRuxX+LJqbH9RPVXAAmr0mDK9Fg7pAnjjFWbsR0h9asrYg8ETx
         Npnw9UaCsCx4POnfj2S5Ckd3RKPVRQpsl/XECWfE1MY1XDlMVuMPmMwGA+oHomKaQNte
         T1XNx2l0IOLq6w4P4VdW4SVnzCnY4RtNQNGAkVXMqevLx3eCRDjUDV7oLh3qm2tkRyaH
         cbtTMMFOFM3yoUwun38dOttS/Emj15H8McsvbFRBptt7eywDgj9TJeH62axCHs3Dan+x
         xNKA==
X-Forwarded-Encrypted: i=1; AJvYcCVh2J2buLGGJTnClvQqgs9fWJLpRGacNhKRd9tJ95eCTZSmaCbk3krRjNf6M8SpNR07btxVKnZL6WJ/rw0TTs3os8W4i016mtAZwr8OGi3Fip4vK4yrxkWlWy0Ay5IgvrLNZTkSbA==
X-Gm-Message-State: AOJu0YycbTO7voi5YsMNMnbRtYN7NY29tfsACld8XE0fPZdWYeP29ah4
	ZQ13qXTFQ5Zn8gMrmm2zssrjGnwNLzM+BDQ5KhknX4PzKJDvoOv2
X-Google-Smtp-Source: AGHT+IGMByHWqBPh6M4Vf0fsbuoeaQoQiRD21rHHB5Pbjgt5qNriJtG2cR0ishk+0ia2O8rtKRlCfg==
X-Received: by 2002:a05:6808:bc3:b0:3c7:747:f361 with SMTP id o3-20020a0568080bc300b003c70747f361mr4370342oik.14.1713456123003;
        Thu, 18 Apr 2024 09:02:03 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6f51])
        by smtp.gmail.com with ESMTPSA id j28-20020a63fc1c000000b005e83b3ce8d9sm1611642pgi.8.2024.04.18.09.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 09:02:02 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 18 Apr 2024 06:02:01 -1000
From: Tejun Heo <tj@kernel.org>
To: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: lizefan.x@bytedance.com, hannes@cmpxchg.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] cgroup, legacy_freezer: update comment for
 freezer_css_offline()
Message-ID: <ZiFD-bRWbYeS-XjW@slm.duckdns.org>
References: <20240418124349.916770-1-xiujianfeng@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418124349.916770-1-xiujianfeng@huawei.com>

On Thu, Apr 18, 2024 at 12:43:49PM +0000, Xiu Jianfeng wrote:
> After commit f5d39b020809 ("freezer,sched: Rewrite core freezer logic"),
> system_freezing_count was replaced by freezer_active.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Applied to cgroup/for-6.10.

Thanks.

-- 
tejun

