Return-Path: <cgroups+bounces-3746-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4294934237
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 20:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6C2A1C21137
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 18:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCAC183074;
	Wed, 17 Jul 2024 18:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeSeHcpC"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1444B12E75;
	Wed, 17 Jul 2024 18:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721240686; cv=none; b=fFBng0iJdX9iPOoXVEqKrXEwyoyUHMnC7vXt4HEiMIocSyN1z76C7azzbrmNlRtNb6YGDOjX1F0UXo+2eoix7NYa4qpc7NhlfTX/NK4PnbBKE7zPPUBKflE/Ja5UiwNgS6+r0lvcsoL8ZRaus8VBwrw6AnxGtPsJz7gmVNO1HW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721240686; c=relaxed/simple;
	bh=3ZiOzrdA5ij0LojDfAufOB0th3VdWvPodatL3cBcGLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJeUEAk7ZVs6WmvypQ860GMS5Cxn/pBHwSNqhinl0fhrA8byohCWzZtYd8NS6AymuFDztTQNeeDGTn/hKtHQsmHt01g5wdXvTA1bSqlr4UoE/rgNSGla1mQSGmvh/jAfNbXD7Flnm8CkFiE5Mh5BNW0GhZWEGgSZg+CwqJI8gZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WeSeHcpC; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70b5117ae06so5115892b3a.2;
        Wed, 17 Jul 2024 11:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721240684; x=1721845484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TVRW8hLHIUSZNhVfLPVIOXLlJElKjBJKeg9q2jucIOk=;
        b=WeSeHcpCnWlxaJy8JH1V7/hVzgezDPAWOSevSziwaYLEptxMz9AqzTs94MTgsTooTa
         /JVs5JFrxDkuvtVHgDzx25bSwi4oIwqF5GP0ne5FNWE46XpZEjv2643t+cmyJwxkH6mh
         a7MFrDjIL6HcXaDQ3xS2FoMBjjNENC6chkymUAhDBXIbicfy767b4SPP04qlYGr+KOte
         igPtE74v3+BXolmUY0TLynos2KEl/GUDCDamvxcx8rrlkfhRSeg/J3/rFxIT/ZUTn8/y
         S/8STPst6S7Sppky8wipMa0s7JOMw9Pmd/SJqFi4hq9c0fe6VKCeg1KZBswT5G9Xt9n8
         Efvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721240684; x=1721845484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVRW8hLHIUSZNhVfLPVIOXLlJElKjBJKeg9q2jucIOk=;
        b=clU2hQnUBb48DKvYNOI0LXO5KpUBvNH4Mc/zlz0lQwbcv/ADEIp/wOcsIpXwX4CpZ1
         1VJ/ZtoOcet4Pn1az4PBhcX3P+SE+Ieuwoiep+6atM1Vu1aRXMEsjmOvu5rzHz3RnNuw
         SrZrxnlOiFFDinAnKWhZhZZaVLCAbr0D7JqKeLEqMHB5lEFVivzJe7SBd9POFm0d1vau
         MwyZDPmyoBt7hWV3ljtTvXImr+jhOH6qrV/lQ5m6+HnF0YGhEsh7p6IcKM5Af+G7HCII
         GNPSGCatnAHIqGnf/9DiODA1XqxskeyHxdMJqmiFBfiDai/YLFdDV2RWa9z0GTLw/1Bo
         uaFA==
X-Forwarded-Encrypted: i=1; AJvYcCWb1VnJqjBoJ0cPPMlOBE2sDOmmmofsd11c2iw7MlZuCrt0fqtZ6iWRgm8+rruGm9hrvXL7prgFagLzoAjRKvCrpTWwVE5ytStI/WLtFOkNujvzK2DlpP+z66dq0HkDKcoA9LQy4x48N95fGmptEvziiNTu8dx0xDP+zxWeuy6pwGqy
X-Gm-Message-State: AOJu0YyUYXtMA+9itDA3q+sPsF08l+rEJr1i+7k0EbKNJgbF4XZMQ62v
	E3RKK1Nf+QYYcft8WBBOZHHh/m8G1Eh15p8ARjSAIyS5VqRCpv/f
X-Google-Smtp-Source: AGHT+IG+8XAut5x9RnVX0256xGnt+rKtGG2XFJero3WSej4KWrPLZ7hzVXL3loyY3SJ2Mysy4szevA==
X-Received: by 2002:a05:6a00:2d83:b0:706:381e:318c with SMTP id d2e1a72fcca58-70ce4e8d2e5mr2750414b3a.7.1721240684126;
        Wed, 17 Jul 2024 11:24:44 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ecd2820sm8436751b3a.212.2024.07.17.11.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 11:24:43 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 17 Jul 2024 08:24:42 -1000
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
Message-ID: <ZpgMajKn2O521H2s@slm.duckdns.org>
References: <20240716075206.23121-1-boy.wu@mediatek.com>
 <Zpbify32lel9J-5I@slm.duckdns.org>
 <c5bcbcbaeacdb805adc75c26f92ec69f26ad7706.camel@mediatek.com>
 <5560c690cc6de67139a9b2e45c7a11938b70fc58.camel@mediatek.com>
 <1b19b68adb34410bf6dc8fd3f50e4b82c1a014e4.camel@mediatek.com>
 <Zpf3ks2drDZ7ULTa@slm.duckdns.org>
 <f448f66b-7a91-4281-8f77-159541cbacff@redhat.com>
 <ZpgB9kCAxAAXAtSi@slm.duckdns.org>
 <134fc34c-10b8-4d00-aaca-8285efce9899@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <134fc34c-10b8-4d00-aaca-8285efce9899@redhat.com>

Hello,

On Wed, Jul 17, 2024 at 02:18:39PM -0400, Waiman Long wrote:
> Well, it can be confusing whether we are dealing with blkg->iostat or
> blkg->iostat_cpu. In many cases, we are dealing with iostat_cpu instead of
> iostat like __blkcg_rstat_flush() and blkg_clear_stat(). So we can't
> eliminate the use of u64_stats_update_begin_irqsave() in those cases.

I mean, we need to distinguish them. For 32bits, blkg->iostat has multiple
updaters, so we can't use u64_sync; however, blkg->iostat_cpu has only one
updater (except blkg_clear_stat() which I don't think we need to worry too
much about), so u64_sync is fine.

Thanks.

-- 
tejun

