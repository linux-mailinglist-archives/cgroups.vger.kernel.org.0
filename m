Return-Path: <cgroups+bounces-2876-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 373858C4C1D
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 07:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C76F91F23B17
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 05:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E901819BDC;
	Tue, 14 May 2024 05:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnRBuXES"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BC4182AE;
	Tue, 14 May 2024 05:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715666144; cv=none; b=n1QG5rNh9AGWoR20aNI08GhxeYkKsOJbvegJHOV80iUxuVaKh/UZDa0C0m1oGE57Atx8mOm+eKmMpncpn02XykXXQ4GJo2eefJI72K7dVrv2C7SsYzucd+ACSsEORRYOOO94yq52DqFRGzyCJkzngjdnLCvpNIN8+Wu3HE6+PuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715666144; c=relaxed/simple;
	bh=7E4zl3qvXcx4BC+TUlRpaN+JchwtVW7K20SANmRkhvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhQU2SK0T4X/DEYQIRhGQ8Uw2yMvnQuGrNzJqLalnZSihkWxLLV7bhXbUU4DBj8SYR7ikaShbDRigv217LSVQSYq+4pJjGXu7olc8IJuH8qUqUNWpZZ5MxtjhrsV7rxPNiVVlv6yrou8dAqAoxR9PK9/Q3bDfwDAzkdNpR+vmQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnRBuXES; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ed835f3c3cso45429685ad.3;
        Mon, 13 May 2024 22:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715666143; x=1716270943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Valc74lvXAwD6+y7W85medmI0BL8q37OKUd2fSWd/YU=;
        b=fnRBuXESOHxOuhqm3pVyL3bDENwb5A/mV4MBIVV+IHsJlbiw53FScgmDYxFR/kUubJ
         Q8ltDR6H2yZfD10l1KnkrGS8FtpS0DErNCsuqH9/hMC9mzAlpHhkClPZZiSmugWn6bQx
         yQm9gkMvPBni46L86ufj88g9vSO/XeFrQoT6RReN3vyVu90AibJ4g+xSuETtizrFdemk
         uECJlL84f76GWXxOgnN7wS1T64T9jsz5f8s0MJZnxcIguKxy74P99HmiO1FkiAtIwJ6u
         8k51XWYu0KxrGtvanzG0oZsnMesLqsAA4nCeYhH0TXiHykTYtdN9NK/juEQps5WQz5ER
         Qk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715666143; x=1716270943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Valc74lvXAwD6+y7W85medmI0BL8q37OKUd2fSWd/YU=;
        b=CY8WD9SZlxrHsokYOG21c9wWMd4CqBd4z42Cep08dOmF2K7DSgP0alB5yQKtWn2jD4
         VZxIXA4z8F0a/qE/z7aqDTP1SYWmbpPuVNuIuS3HwLgdlMcTJM3PI5lwR2Tqgni422cm
         B6bY2HbPG5cyrR0y8GWZ/rPmxk+o5JVw9E+33ui9XhWS0rvnanbeRnRNzC7fvq1U++3C
         LgYnOjY3xriwtj/MHFVjIIN0N8n6oluI1XyleXWw9pWp6rMrtOpTskGuaXjz59xoW/R0
         yhzFhVfyleJKOCLSoGHh53jPzPyPRAPCFR7dIJIPC8UQOjPiueHhzHtdPDYTW0x364Qu
         OcPw==
X-Forwarded-Encrypted: i=1; AJvYcCWl2pfSxfZC2+af3jakl+xnKyLi2HzpkUlVrAFdYPbC164Arsl7pmugQw8gw4twr/3jVRbgbBDpp5E9eI3bVFGaGzuwfm/6ooHrSk/hUja7A+rHazC+cz03CQ4C3Ro58Q==
X-Gm-Message-State: AOJu0YwnvKkQCbHnVzhuX3xJipLi3Z76NnapvEDyo5ZFBg3vVvX8p/li
	0CXca0W0/0kAeCz/Xy4T60FCT5TCNu/F+lbtWNkICxuGeMlmb8zKVWwmnA==
X-Google-Smtp-Source: AGHT+IEvsJOgch+NsjTC4HgYob0dTbJ1kB6MJhSMWFi6JZDGO7axZbb1C1z9Uw3RNRGIVU/lYe8GMA==
X-Received: by 2002:a17:903:22c9:b0:1dd:878d:9dca with SMTP id d9443c01a7336-1ef4404a347mr156742045ad.48.1715666142601;
        Mon, 13 May 2024 22:55:42 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c0362d4sm88776495ad.210.2024.05.13.22.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 22:55:42 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 13 May 2024 19:55:40 -1000
From: Tejun Heo <tj@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: hannes@cmpxchg.org, lizefan.x@bytedance.com, cgroups@vger.kernel.org,
	yosryahmed@google.com, longman@redhat.com, netdev@vger.kernel.org,
	linux-mm@kvack.org, shakeel.butt@linux.dev,
	kernel-team@cloudflare.com,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v1] cgroup/rstat: add cgroup_rstat_cpu_lock helpers and
 tracepoints
Message-ID: <ZkL83GKD7sga8tFX@slm.duckdns.org>
References: <171457225108.4159924.12821205549807669839.stgit@firesoul>
 <0ef04a5c-ced8-4e30-bcde-43c218e35387@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ef04a5c-ced8-4e30-bcde-43c218e35387@kernel.org>

On Tue, May 14, 2024 at 07:18:18AM +0200, Jesper Dangaard Brouer wrote:
> Hi Tejun,
> 
> Could we please apply this for-6.10, to avoid splitting tracepoint changes
> over multiple kernel versions?

Yeah, I can. Waiman, would that be okay?

Thanks.

-- 
tejun

