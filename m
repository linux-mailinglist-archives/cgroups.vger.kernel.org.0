Return-Path: <cgroups+bounces-8246-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E910ABA318
	for <lists+cgroups@lfdr.de>; Fri, 16 May 2025 20:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF633B72F4
	for <lists+cgroups@lfdr.de>; Fri, 16 May 2025 18:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F6F2798E5;
	Fri, 16 May 2025 18:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xmoktlVs"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECD2215043
	for <cgroups@vger.kernel.org>; Fri, 16 May 2025 18:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747421228; cv=none; b=m4HhCWdjIVd4ULzmBnShP8orZv2GgeOvRKvaaieAoWVRG23ia29PcV6FY201ngcDGN++CJ/YFxgv3Iy8MXQAN44i7WSNaAKxqEeFT5IGdJQqwMtzPe/mp5uuybHvN71YGaC7sXkD7LQn7qUbewkwCH/vDCSNlKOgRx3y0XoNxLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747421228; c=relaxed/simple;
	bh=XQzr/P8LSzc1fGmKf5TzJFNWuKpMYhmvBe/dgZKthmA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cNamipeSbHn2mVtilvz6hk7zUQqdFW8fOoCdIKtOMhUcND8MEbAs6k1njZhPlEoViOfqNH6VLQO6F8cRoXHKvXD3OQ1VDjEFuThVKWbvBIraSqz/lASfOaPiVbopRWZ1qPasb4bp880nmZkbuYlF4WcKF/Df3aZyQSL+v6DcjYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xmoktlVs; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b26cdc70befso1543383a12.1
        for <cgroups@vger.kernel.org>; Fri, 16 May 2025 11:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747421226; x=1748026026; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qmq5yOzKEYHGMlWUHQrdCglzBtv7bOn/Y4UXiljdeIs=;
        b=xmoktlVs5hMz9PDKC8NIaTrKDZRwzdbCk4gj1oH3op/wJ9crQFte+iJl8WtOSDuW13
         j+55aZFs4lVQU9VNhg7Puk38H7HQzqFnYeE/flXuxOqrx44kNm5juM/5NumeacWOgIUn
         h5w8RJVRgSd1/7WYX2PNff7ySpEYsZLkqPMIO0LVRl1yQVaOkQKHX3Ttq7vE0mKBSER7
         YQ/blYHQtfhLUMod6mfVDb+/Ls8SdB2zAlLvc2HjnyiNMtZcBCRmJe5VGxotqkF+JLGV
         RYRB55wwxrqy7yCl+RzR9g84g0pObt5boQBp8jfig4xSZqf/PHZCuKpc0UaIIJjp33kY
         K90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747421226; x=1748026026;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qmq5yOzKEYHGMlWUHQrdCglzBtv7bOn/Y4UXiljdeIs=;
        b=ePck5rAQ6nUj4vNoDu3GrqbLEMZ0zrWFTRLBm3elegRaFs/hmdiE6fz31Hxwwi7BBU
         qUsQUIFT3yP7HJ2gFJSR9p5a0YTEggxaGnpd+K3zQsDX/KpU/yqz4FOyv5ExWCeqPRUp
         7YubAA8lhtbJqfY4+mxJPoYjmC6GZi1ihQjDf/Xh0eAyYPY0dG8mqWf45Vn4IhXtLadI
         VXaOp7+PSlZoSWSm+B/eBtTYUTZ7xJiUWq7WNzN4YRpsBN5FZSxvzqL6q5QHEvtbD0e6
         3wpAyWYWLWMHUfttM2KVzjF0CTyKu6kEXSJRmOI1eEiQbu1k5bElVKxbgbDzeITym3QW
         Eo5w==
X-Forwarded-Encrypted: i=1; AJvYcCVth4C7G39R0nWWwjKIPu5EwZXH/SaAN6cYSQnE0hfbxibm7ZefMeGWRIiC1TMWhgkFImzDgKGs@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8MRt8y7eLjMWbG1kzUhhYbTl8AWNCML2CMCI8ThASlqinBKW9
	gjDtyFi26SLz6gd/Ffckjjw8t/9MyXDAN1LHu0URSt74djPNhMVxFX5diPIuOe/cKK31l8Q8BPZ
	NVlNpaw==
X-Google-Smtp-Source: AGHT+IEoABAHTdXlaeskcgYJu03drz+RNn79bIJemm7dWQc6taI6oQUGfiZBOrFd1GdJMi2Hp8JwioagtxQ=
X-Received: from pllb5.prod.google.com ([2002:a17:902:e945:b0:231:e3f0:e373])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4d2:b0:231:faf5:c1d0
 with SMTP id d9443c01a7336-231faf5c3ecmr19177195ad.24.1747421226086; Fri, 16
 May 2025 11:47:06 -0700 (PDT)
Date: Fri, 16 May 2025 11:47:04 -0700
In-Reply-To: <20250508184649.2576210-8-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250508184649.2576210-1-jthoughton@google.com> <20250508184649.2576210-8-jthoughton@google.com>
Message-ID: <aCeIKDbwVIlBLtGz@google.com>
Subject: Re: [PATCH v4 7/7] KVM: selftests: access_tracking_perf_test: Use
 MGLRU for access tracking
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
Cc: kvm@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, mkoutny@suse.com, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Yu Zhao <yuzhao@google.com>, David Matlack <dmatlack@google.com>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, May 08, 2025, James Houghton wrote:
> @@ -372,7 +501,7 @@ static void help(char *name)
>  	printf(" -v: specify the number of vCPUs to run.\n");
>  	printf(" -o: Overlap guest memory accesses instead of partitioning\n"
>  	       "     them into a separate region of memory for each vCPU.\n");
> -	printf(" -w: Control whether the test warns or fails if more than 10%\n"
> +	printf(" -w: Control whether the test warns or fails if more than 10%%\n"

This belongs in patch 2.  I'll fixup when applying.

