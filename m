Return-Path: <cgroups+bounces-11069-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA8DC04904
	for <lists+cgroups@lfdr.de>; Fri, 24 Oct 2025 08:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45CD51A62A18
	for <lists+cgroups@lfdr.de>; Fri, 24 Oct 2025 06:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33D126ED3C;
	Fri, 24 Oct 2025 06:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PlTw5qoT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D8B2652A2
	for <cgroups@vger.kernel.org>; Fri, 24 Oct 2025 06:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761288654; cv=none; b=DLy9ZcBRH3H3eXeynjVOxliSXdERhdhtaXFzecuq5OVVOGw10EZOVrGR+gRrlgD39ioGqKbF1xafMWfP3TS5WSte+dzEQXOQtIAOfuXHfA5LWhQmCAzOuP9xG7xMInIchpUOTuC/hEHySt5R10f9WJMESX6rn0831XkaFPIz2Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761288654; c=relaxed/simple;
	bh=gNJBLOaDB8XjEP7AnjsKksq0AWMpniJyz3WgFUGQArY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkKmp4bIMYA66sjZVhSqSROJROs+sTuuK8CwhfipMyDT1ZxNGjeTa78IFk+xTpYVK4RuVUT39vqv+sSo/uMbxdyU7xvrJdlLyK7aNsWLOu6MuP1rd9n1Z7mOos7HN6+iWnFSP3QKPq0Ey6io9tLByPGxveLoz/Yujszrhs7SQJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PlTw5qoT; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4710022571cso17560525e9.3
        for <cgroups@vger.kernel.org>; Thu, 23 Oct 2025 23:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761288651; x=1761893451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cTVHW40Zh+ZcYW36HL4c/rT2R0nqusYCaOB5DUxW5hs=;
        b=PlTw5qoTHtlQLUdH9VQuIazcx78CQZhjMAe1qEfedhSTgCpebUjKyAXwmMtzTcrrBT
         W/FKeNsN/i47gN43cY5qXCuO5J4MrvqUFO/obkByR+szYbSvpw66q9Vyi44C5BBwKmb7
         8gCspOMZkUIPgGXOMNP51EZKNz7zUigzgvp73CIStmhCyctwItd+ALAy30geNlymivl1
         H9U2oTThmtxYlq+KZ+Cr9HFzgP1Uyi/+kOjgjXhElW8FTi0OEGhBTCLwggYsZ6j+Bvvu
         F9YV7ugxFelIL0vVYJUh71RrS0+NL/bIN5Z5dQFtiu9knZhc8L6Grmo/p4rFyn+nJqTy
         aQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761288651; x=1761893451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTVHW40Zh+ZcYW36HL4c/rT2R0nqusYCaOB5DUxW5hs=;
        b=Cuvr6vF04Z2Fr4v/isfasr1RoeuyMy74d3obtKXtM7UKrx0ZgIwIswjcy23DiKKhFT
         vuc/GP2LpuU0jFuZ9rEA4yO/YlSeWuEv0E4h3fMydonuMdS8331uLSs/r6vbLjhzqIdJ
         hzD022uF0/0D5wdvNWla4yYgBsC5pUVdVgodviJ7mSSefq4ZlmWs8XeOECmfkFZNEiqk
         tJ+3qaof/TW96lAhcs27EcUFrxf9Yr7gVh9tSeG2bPSrupfF3SXwdN5LtM1XwEvYplPq
         czOmv/7YfPrkouNjlecRJamcKnFMsYYN2K0f7w4zbw/t+wBLrPRwRTuofTQmebKbqtqW
         J9+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJv0KEA2qRVDV5ycXK8RgIR040a2eMZ+ezT3VPRTw+vxtNAOsPcU06ETOWu2PRrHykA8eMthrb@vger.kernel.org
X-Gm-Message-State: AOJu0YyeTVy17+f2ixYyeBj33BHbEnB1UBpG+zQ40w7VFEaum2ATLRIO
	V88rkcHlxz8rQRMs/kPAMvq4CvIH4iS01NEtOlO8L2iGEzlPe2IcePHgzgBZGg1OaX0=
X-Gm-Gg: ASbGnctxUApE5ZOod1eGgfyP7I057zfRytrj5gUzToBR41VC8+wIPZpvu875IQ9u/L/
	2qlAHVvvR+z7aov3tunrYifsXtoApGlyAtH5JfQ0YdASzVK+cL8G/9Lkneta7MgpBRE2/7WfsxD
	T09f3bj6E1nw4tLnni0X1mS9e2+TjKO1lx//+xJMQCzZvuoU5U+ovzmWShB0UdNbQywdM11jVuX
	kjG816kVhluWTvY/rHM9nWLe2B9DUU4GhgsZzuhH6AxJbv6HB+r8kc9pcOIymbZfxg7Tkt3ikkK
	FQFJDpuzu+3iHr+7eG6DpmL3GUC4PaWjsqFeex1RJtTwccnI6CS1CV0q4zHaX9XSAz7x5gicmG4
	ykTHOl/1/nePUrg9BQ3GREfcB2/ZB/L0Dx3VvxvDa2TEQObDD+noxRkujOH2ELM2adxvDcCiuzZ
	uUe3Q0bv6HcwI=
X-Google-Smtp-Source: AGHT+IG6AHY5dkgO0Q5DKGmqzwIVnALLho0wguGOP10IdFFJoATiZ5dycE/1wRVFF3VxetAiLmfC9Q==
X-Received: by 2002:a05:600c:3b03:b0:471:6f4:602a with SMTP id 5b1f17b1804b1-471179068f6mr191913555e9.23.1761288650660;
        Thu, 23 Oct 2025 23:50:50 -0700 (PDT)
Received: from localhost (109-81-19-73.rct.o2.cz. [109.81.19.73])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c427f685sm135434275e9.2.2025.10.23.23.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 23:50:50 -0700 (PDT)
Date: Fri, 24 Oct 2025 08:50:49 +0200
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: manually uninline __memcg_memory_event
Message-ID: <aPshyb6okUnRMZQL@tiehlicka>
References: <20251021234425.1885471-1-shakeel.butt@linux.dev>
 <aPorFhxQc7K5iLZc@tiehlicka>
 <jnzfiyojjwvrj3eemqmpigfyjxucdqe44fjy36nxkly6urtn7u@a6pfcppla3r6>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jnzfiyojjwvrj3eemqmpigfyjxucdqe44fjy36nxkly6urtn7u@a6pfcppla3r6>

On Thu 23-10-25 14:35:05, Shakeel Butt wrote:
> On Thu, Oct 23, 2025 at 03:18:14PM +0200, Michal Hocko wrote:
[...]
> > As the only user is in tree should we make that EXPORT_SYMBOL_GPL
> > instead?
> 
> I just followed the file convention i.e. all other exports in
> memcontrol.c are like that. I would keep this as is unless you have
> strong opinion otherwise.

OK

-- 
Michal Hocko
SUSE Labs

