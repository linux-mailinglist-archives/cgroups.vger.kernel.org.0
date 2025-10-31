Return-Path: <cgroups+bounces-11466-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F52EC263B7
	for <lists+cgroups@lfdr.de>; Fri, 31 Oct 2025 17:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC46E4F7AB2
	for <lists+cgroups@lfdr.de>; Fri, 31 Oct 2025 16:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C642F2F6160;
	Fri, 31 Oct 2025 16:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gd+Vq+54"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24903289374
	for <cgroups@vger.kernel.org>; Fri, 31 Oct 2025 16:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761929338; cv=none; b=OuGElp60BeGMjt4Sa2jNDn58F2+b8x9ph/RZVedNg4UAEWHgwjeVN1txaA4294Lv4tqcP8urBOJ0GQo+A6wKv8QgB61Ej50Dby4UdlrSjET1wO7hfI5t7YWILBBX3t9AfeKIBiVZWV08URlmes81sf6RPHJb2DPHLxQGQlqPMh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761929338; c=relaxed/simple;
	bh=jkmdMqGEGLTAlWpJzbFnFqAwY8BBbmWukGoDZnvbHLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XK2f7rb+l4ShFJobzlGCQGM0XNRJw05m/3PWe/Iw11Jt3nXffONybJ8awzc+gzUMG8llqKl7l46EGBS/pZnKVwXfupAf4PnzScq+jJspocHheSd3jVLxJwwdi9AKKBUxRMREro7Ci0kjl+Ud5FaKASkHabJma6rwP68Co0LwfRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gd+Vq+54; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-78125ed4052so3565505b3a.0
        for <cgroups@vger.kernel.org>; Fri, 31 Oct 2025 09:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761929336; x=1762534136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lgb+9C3jvqIAil5vMaPqTfTmFra5MOD9hf+0ALcR1eE=;
        b=gd+Vq+54MXmvC5nvbN879S4ri6sxSBUwohX8qDc5jnZQl6lhgbNrMEykQP0cNSuhB/
         ClasQv1XTo/KBgJ54eSq2PtB9Wjm8ZBGmxuk1cPrIiPwCwHjpCwgaIvDM4gPvNv7ZjoP
         5WRVKHiaY2hPnXKYOGbLF17aGlaUL3bpPdM7RCKkk2zMmzXd1CmZQr4Fl19F3MWeEZxy
         Sbzo0VInSsmjQFyCDA5gCPwbJG39CYOdS/zhie658SAmNY6w6cVfkqfRV6FF6RvoS7/D
         OouEt+u3p0ARrhHu8gjlmrQJPGVHZm9vzf1gQmwADhLANAY/GyWzSasfl4nEBhBkwm2w
         wvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761929336; x=1762534136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lgb+9C3jvqIAil5vMaPqTfTmFra5MOD9hf+0ALcR1eE=;
        b=fhNejA4CZXyIbjN83/LqpP4BALGAY0AmVi0JjvqUja9AXwkNopN5mdheguicJnIJO/
         dZCUCbb5RLUG0JWjM9YUTTEXL+NWO3bQs25Lxos+WKYTkSegmGYynKOVtlLocrpklCoE
         yAQiQ8jkjrwuuK4m0ld3uuWtz4F8NnAf6n2cjLAVt9LI3hb8JOkxbZdq0RXUhqcA3P4j
         W3i54DJ/YRXJ9m8pW9JLvl/CLnsK/tMozoTKDFjkfxN5iNUdXoFR0LhqHAI0yxSouGJ6
         mCvyhVlyGTUz69iXEh9XZ6Gmm8HlcWEJ1n/jL+ALCq55sDZgYSNxLaRsAoVVa+bMMeec
         78mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoLk3xDRiO+9JdFoBlSQ57uR8xxsCkBUVjMsVptYa+TGfNsosKu3CzS/W+j7b9fTqcCZeApe9a@vger.kernel.org
X-Gm-Message-State: AOJu0YxV+PgZYtncT/6xgN3BZE1zrqJed3CA1A4UpTj4er7a+1dWI2Ur
	DsLi2yzqQimsGThfca4YrM14L6NNrlliZSyipnbNNTFKLtKCpUCrRVDG
X-Gm-Gg: ASbGncs3OHoYb40Mnfvix57nwET+IJTPHP5mWHw7OGnZ/mJzUhkiesMALsgSySiSDBL
	QY0g1NrLAdIm/8r3EBSx/8w0kKoj6L6XeIE4NhCnkxKYUazVWAWvmnXuPBYCBNaKToF2bKrkVFt
	uctoG1OWP8aMB7jH0tY6HOolnwZTEZQm3X7z3l+AzRrhJZ0edIQ7CRsx1mV+7Fkw6O3JwyPdZLB
	cdXxObnn+ofyhh8CvwuLCCfAHwgaeUmxEE5UW6VLMsofhQ7h6/ag4ePBnMqMT+OE9fbT1XAJzt+
	qPyDLevXKTyv0jqKXjibErRMhIcRWcyGFtWYa8zOSVWLtjHCa6XeO+i+gjCJUCGtlYlGgLMw1mz
	WbC4Y+/R7/ndvCOu7DzSrzE4YH/IBcvKXIDdeLE0f5JI1FPv+Sn0KGfyfhK+MFhaRYVYstDXw6B
	YCYHjncetepV6rZHM/3/8t
X-Google-Smtp-Source: AGHT+IHzisb8pOTUrWEeEIlE11gPDxItgXXojG7g9LRH0MLHpSQGT5VIV7jL+XPyT0+qo+/zJb0lZA==
X-Received: by 2002:a05:6a00:9291:b0:79a:905a:8956 with SMTP id d2e1a72fcca58-7a77718e95cmr5394654b3a.14.1761929336301;
        Fri, 31 Oct 2025 09:48:56 -0700 (PDT)
Received: from localhost.localdomain ([124.156.216.125])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db0a26f2sm2755863b3a.41.2025.10.31.09.48.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 31 Oct 2025 09:48:55 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: mhocko@suse.com
Cc: akpm@linux-foundation.org,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	cgroups@vger.kernel.org,
	hannes@cmpxchg.org,
	inwardvessel@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	song@kernel.org,
	surenb@google.com,
	tj@kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v2 00/23] mm: BPF OOM
Date: Sat,  1 Nov 2025 00:48:44 +0800
Message-ID: <20251031164844.27060-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <aQSB-BgjKmSkrSO7@tiehlicka>
References: <aQSB-BgjKmSkrSO7@tiehlicka>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>


On Fri, 31 Oct 2025 10:31:36 +0100, Michal Hocko wrote:
> On Mon 27-10-25 16:17:03, Roman Gushchin wrote:
> > The second part is related to the fundamental question on when to
> > declare the OOM event. It's a trade-off between the risk of
> > unnecessary OOM kills and associated work losses and the risk of
> > infinite trashing and effective soft lockups.  In the last few years
> > several PSI-based userspace solutions were developed (e.g. OOMd [3] or
> > systemd-OOMd [4]). The common idea was to use userspace daemons to
> > implement custom OOM logic as well as rely on PSI monitoring to avoid
> > stalls. In this scenario the userspace daemon was supposed to handle
> > the majority of OOMs, while the in-kernel OOM killer worked as the
> > last resort measure to guarantee that the system would never deadlock
> > on the memory. But this approach creates additional infrastructure
> > churn: userspace OOM daemon is a separate entity which needs to be
> > deployed, updated, monitored. A completely different pipeline needs to
> > be built to monitor both types of OOM events and collect associated
> > logs. A userspace daemon is more restricted in terms on what data is
> > available to it. Implementing a daemon which can work reliably under a
> > heavy memory pressure in the system is also tricky.
> 
> I do not see this part addressed in the series. Am I just missing
> something or this will follow up once the initial (plugging to the
> existing OOM handling) is merged?

I noticed that this thread only shows up to patch 10/23. The subsequent
patches (11-23) appear to be missing ...

This might be why we're not seeing the userspace OOM daemon part
addressed. I suspect the relevant code is likely in those subsequent
patches.

Cheers,
Lance

