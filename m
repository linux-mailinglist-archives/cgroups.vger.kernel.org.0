Return-Path: <cgroups+bounces-3008-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCB08CF58A
	for <lists+cgroups@lfdr.de>; Sun, 26 May 2024 20:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9FEE28120D
	for <lists+cgroups@lfdr.de>; Sun, 26 May 2024 18:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F8B1DDF5;
	Sun, 26 May 2024 18:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GP0xJ8qa"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E071A2C21;
	Sun, 26 May 2024 18:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716749312; cv=none; b=XmrDyufATzW/MCDt3Gs+d5Wz9ZmQ/SwWaPjt5U1mVU2wLvTyCJRrfe8BjyGc1frcTS0R5iLQBt0WTJFMZHqJhhUkribs+gToz/Cwez3ec5pyB3wM7KtGRDe1lDj5EywjeGGKYYvaFstzoy8V4AHQA8YPf1bBvxJeGYJMsmOFnDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716749312; c=relaxed/simple;
	bh=TF/UNXQWWdLsWt90+jGYm/owjZhwkxqzfJ5ba/MKRQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tj25GlVHbHAxKQfaP9ITFTbxdznzasda0zhLw8EEYX/2Al8lP0d5sWk9ZwERi7wv6fH8tju4FPDeeg3h2u9fu1eO3onhZ8bjfbaxM1VH06LoWjPfw/Es11X7STNnAzDyxC40mzbphFjEAkpekXT8EXxYWfsWlh1I2Y+tlGHBG0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GP0xJ8qa; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2bf5ee192b1so1530207a91.1;
        Sun, 26 May 2024 11:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716749310; x=1717354110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8KlyDkDuX+WiAzqsPCy5DCuGhhVymspVkX3ksKKJOrs=;
        b=GP0xJ8qa12yXGcvfo2W94GBlHDZnK6VxEjYSCzRk+um7T/dGqrN6+kMihxkLa9TdRn
         VasVsCiFFhmg0DI+VlYrrjhi/2bKoipIu6YC/JbQCLrv8SWmzyPMYJQQZWH0KqyMbjQn
         cjGhqbfxQoKAriHLcpp67g/1Ssyodl6YjSnR9yNBfoG5mPGobS7rF9R7nJJrS09jwGWX
         eEDedwyHfosGDC5LwtJV2+4yPj0TygsQYDMC02qenvwFvgPOETwx/z9nzyDQooRYdDC1
         fln2ix7sn5y5CcWT+ni67HyV1xqI/pSX2zCRC3cr6DIZMyvksTYFkgRpxvxH+FalWCn4
         0DLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716749310; x=1717354110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8KlyDkDuX+WiAzqsPCy5DCuGhhVymspVkX3ksKKJOrs=;
        b=t0SkrVCNPFNolz6alcRAK4vhV+o8G0Q5y0jD7NUTLIAicm1jysE4Yw0xa1pYoY0cW3
         QsnBrPzzeifEppcMR/7F4ZSsIOK1GqgCPIWtoQdCBkP/rMkXZ06kvwvyZhgalNDs/vWJ
         Ir8fHCgdyRJCWtaIpds4Un5Kx503uIDCya3Rj3SGI/a+LWeaJsJh77J8PVO59KCq0hCI
         mBPAgZ+919eqkULSFDyIsqpxqG/4GFX+0IMiOYiiJdbB/jMOD5enXYsZy9Tz4yCaTefO
         iQA7A89dY6/iwtsmuIuVzUA+eOJPXgQ9AXschnDbG62Qkz74nTJAvUK1CiwWVtoh91n/
         7tvg==
X-Forwarded-Encrypted: i=1; AJvYcCXRnENPcAgDYmyWUQi9zC2brkAU29b5ji7rYwYpMcAWiBH+ewZ7HD1SZZteXatsd+c1ZM2TcRc+5L1NLx/NKmqzwHXVvexr6oHeJFIbmMDKxvN30o0bsnNu39YeeQ79qaEar/3KhQ==
X-Gm-Message-State: AOJu0YzsnFkhkzTwYsFhwwmD2T1cr6WDsGjYLBkcJLlrWjrqJhF4/iZT
	ztBVf5oePWrPxB256qrD7vMl/VxX3RhSffuo1N+FCZF2Y3DsKrQE7QLncw==
X-Google-Smtp-Source: AGHT+IEjDpndjTbVJlwMKdjQTj5fCvqm0vD4JEcJ34Qhk13lt2NrU3dNAVGbkZL2J36ZEJwk0RK9FA==
X-Received: by 2002:a17:90a:ea95:b0:2bd:fe71:14f3 with SMTP id 98e67ed59e1d1-2bdfe71201cmr11297706a91.22.1716749310507;
        Sun, 26 May 2024 11:48:30 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bdf7533fc6sm3804276a91.0.2024.05.26.11.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 11:48:30 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 26 May 2024 08:48:28 -1000
From: Tejun Heo <tj@kernel.org>
To: David Wang <00107082@163.com>
Cc: lizefan.x@bytedance.com, hannes@cmpxchg.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/cgroup: cleanup cgroup_base_files when fail to
 add cgroup_psi_files
Message-ID: <ZlOD_FbX6p3qyGSN@slm.duckdns.org>
References: <20240517062405.115253-1-00107082@163.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517062405.115253-1-00107082@163.com>

On Fri, May 17, 2024 at 02:24:05PM +0800, David Wang wrote:
> Even though css_clear_dir would be called to cleanup
> all existing cgroup files when css_populate_dir failed,
> reclaiming newly created cgroup files before
> css_populate_dir returns with failure makes code more
> consistent.
> 
> Signed-off-by: David Wang <00107082@163.com>

Applied to cgroup/for-6.11.

Thanks.

-- 
tejun

