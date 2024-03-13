Return-Path: <cgroups+bounces-2049-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8973E87A655
	for <lists+cgroups@lfdr.de>; Wed, 13 Mar 2024 12:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4253A282F11
	for <lists+cgroups@lfdr.de>; Wed, 13 Mar 2024 11:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20073D3A4;
	Wed, 13 Mar 2024 11:00:17 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail78-58.sinamail.sina.com.cn (mail78-58.sinamail.sina.com.cn [219.142.78.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DB83E474
	for <cgroups@vger.kernel.org>; Wed, 13 Mar 2024 11:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710327617; cv=none; b=Ed/jgKQAubAbHQ9Z8ei9ADONUQUg+UCUv3urJTBt4XqyyQZYE4hDktudBAjJbF5c7u6nigqYjt7hdP88DW7zVRdaVbZvzBp31ThI1A8LtTgbt3fv8HgxDuBP9pkBORnZPmVRCQzRKCIcR6WjgQDzL6IlrwRaHcsPCu5EeKk60JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710327617; c=relaxed/simple;
	bh=7ZrgMjq9EJG/HOQXQol5+NoWKKlBPFaqhHJffNQBK1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IQ48/C7aqQr/jcpPo4oTly9lo7rNhj91ozvqcthWfPraaMO1T10ApN/1+qjbNHCRkTD8Q7G+g3/otWw80CF9LD1CuIsW/zssiFqda0FLAl84gA0xk2G8Hh3yt0n1j6kkdTp8CIiLZcvgS4D4Jl+dV/V20QqeA+IuhWQ3ojo4wSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.180])
	by sina.com (172.16.235.25) with ESMTP
	id 65F1873100001394; Wed, 13 Mar 2024 19:00:04 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 16864934210262
X-SMAIL-UIID: 0B8297D186AD46CEB1A98DA75BCB2E4F-20240313-190004-1
From: Hillf Danton <hdanton@sina.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Yu Zhao <yuzhao@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Chris Down <chris@chrisdown.name>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: MGLRU premature memcg OOM on slow writes
Date: Wed, 13 Mar 2024 18:59:53 +0800
Message-Id: <20240313105953.2234-1-hdanton@sina.com>
In-Reply-To: <20240312210822.GB65481@cmpxchg.org>
References: <ZcWOh9u3uqZjNFMa@chrisdown.name> <20240229235134.2447718-1-axelrasmussen@google.com> <ZeEhvV15IWllPKvM@chrisdown.name> <CAJHvVch2qVUDTJjNeSMqLBx0yoEm4zzb=ZXmABbd_5dWGQTpNg@mail.gmail.com> <CALOAHbBupMYBMWEzMK2xdhnqwR1C1+mJSrrZC1L0CKE2BMSC+g@mail.gmail.com> <CAJHvVcjhUNx8UP9mao4TdvU6xK7isRzazoSU53a4NCcFiYuM-g@mail.gmail.com> <ZfC16BikjhupKnVG@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 12 Mar 2024 17:08:22 -0400 Johannes Weiner <hannes@cmpxchg.org>
> 
> Back to the broader question though: if reclaim demand outstrips clean
> pages and the only viable candidates are dirty ones (e.g. an
> allocation spike in the presence of dirty/writeback pages), there only
> seem to be 3 options:
> 
> 1) sleep-wait for writeback
> 2) continue scanning, aka busy-wait for writeback + age inversions
> 3) find nothing and declare OOM

  4) make dirty ratio match your writeback bandwidth [1]

[1] Subject: Re: 4.8.8 kernel trigger OOM killer repeatedly when I have lots of RAM that should be free
https://lore.kernel.org/lkml/CA+55aFzNe=3e=cDig+vEzZS5jm2c6apPV4s5NKG4eYL4_jxQjQ@mail.gmail.com/

