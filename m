Return-Path: <cgroups+bounces-11537-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBBBC2DA14
	for <lists+cgroups@lfdr.de>; Mon, 03 Nov 2025 19:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B9EA3BCA3F
	for <lists+cgroups@lfdr.de>; Mon,  3 Nov 2025 18:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65AD23D7F4;
	Mon,  3 Nov 2025 18:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cOd52XJR"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1692264C8
	for <cgroups@vger.kernel.org>; Mon,  3 Nov 2025 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762193916; cv=none; b=H9SOmVS/zojsPlLg/xL8hRJFJnJKYGmH6s5DgEEtdzPNa/KA3awRYw1G4qZq9tHsS1VXHtwwHa9CjvxS4gzpT/+mC5V3wldovMpY4LW2L/lgpyay/8g1H1rmFM1Ev5BHKOAnUPQxXxeAp+0YrkJO9jhWLZ1fl/QKxDYDQASzJ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762193916; c=relaxed/simple;
	bh=URXNs5NVV9mjyIjpTFJ2nbkM6xeZY0uxMOBeg6vFH8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWAgLmNo049LJ9w4oFl4ri8VsUB9vb0Uwl/RzB2fMcNOz+KXc+Be5a43bID/479TSk7KrMvo7nD9BAxzQw1AajYY9LMct4gs+9wLZLnOG4g6KcgfsjVQQpB7BWYIAwCO6/6DG/CLhEJRZRwb1G+6THXOLF4/bTeo9EhNJGXn4f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cOd52XJR; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so949594766b.0
        for <cgroups@vger.kernel.org>; Mon, 03 Nov 2025 10:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762193913; x=1762798713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jqRLjgd8K+hT2Lw3XZjWXjJmFIP7/NT9CeMKS9r3avc=;
        b=cOd52XJRLZb8IO6129H4kd+jNXtLtqXDIfUbNyTnlPT621DrqSW7cJrsRhJOC1JjJ6
         7jRgw+h0rbmu3qfB++z+uE12q0QJeAOScF4U6tibhKHoiNRAyGUH8iMEl1qNXwHH5u4A
         U0eGwkOlgoXxkQDChytZV6mLW5IU5IwP18WLWLXidYJAN9NeF0b05PZkhe/zVVQAHFvP
         eGQxjXhNbhaR5TcrpQA2D6lF3jRerxH2CumgUjl8YgPKY1KIBVnI3pJREGDF8tejk72z
         HzaYuDkn0WLVvVBq8ndNJl5Cd7cGcQDTt1ZR71N4N3gMxTYT/msNy4ZEGIdsbrVcNyOj
         Jr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762193913; x=1762798713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqRLjgd8K+hT2Lw3XZjWXjJmFIP7/NT9CeMKS9r3avc=;
        b=J6RitHwNJabBI2O5mIDo/0DM8U8m0XsYOaLdSfxZ1bNA+9MmY37/NVqZMB06i/VIfs
         1JFE3tankC4ciku9UsKhMoWA2j2Vk9RDvkEIAlAV0NXoisp5DmT/4LkHEteErgDl18wG
         WdO1AgxhfqpqcLoiO2Da8etQiO4rHLBjC3NkELT/KgR4iY2wH/q5VCdUOFxzp6Zpojat
         COhDBJ9lgOLC0KDXFXEy5GUo44iQSW+HgP3CPLyVOtDltcGCUmsdT6htMkiLohDfGW8M
         icOYMe0QO8hkBe06OQ6xTH/iqoJMuvOiNkTj1U5sHu/5IN6HVg2Xt6azDBBs/fWoHCO/
         zmxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN3Z8h8qk6KhQdAZwPX/RSK3h/1z0FYnhGAyEgPTv6YtRLa1yPTZrz46HcFYlrSs9sGj8vCmqG@vger.kernel.org
X-Gm-Message-State: AOJu0YyeymqqDuAn1lAbAU3o8g/upDxwSIbDPCPZxRMpx2QaTxDCbDQa
	FNIu1AQLyffi8svSLvt0AAfi9raDYtBIMMtA84mRHjCbEn0L00RQucp936i5CsoaWmE=
X-Gm-Gg: ASbGncs3kssT1PTmjJasdPxCaCIWqZpY2jA8ZWuqjNZtlfU7Tady1fZSCBKrDuIxeK9
	AiGAJ6dUcyDBrb9wAj48kC6ix/tHYd9u+bcuWlPPRPM5+XGhdY4yANe+z0xilqMaUSUDHGEJDuK
	ndsa9o8GS2aQDyHYaFe1s1XcDA+TlwReFkLe8GRi9hsDPL7QYwqISOmIRqxei6tF70/qxtfZyRQ
	KxnHa7o29jemzniV3QnA7UeNN7F7mMvFjnkI+jDNjz6bZeIzeG95YLNX3COdPijQUaKhywA/FPu
	oo52g9Ybm4ogD3ZCKpZ9aYT+CT/ujQvsqNJz/YG8H2CoyejPCIQlWYeBJF+Sgr8JKd2s9mwbjAi
	TCd+UwaYiaNTcjR9G/jlRJdMbUqHWpsnXZw34acIHxDDus89+DqNEKag6TDXb+8O2dJbyphCSKh
	gxk4NmBqrSEtlM+g==
X-Google-Smtp-Source: AGHT+IE2daxTlMOHk/CGF2RugDrn4nke6v1czkbTOpjMgsbAikWRjv6WYKeA3oTiX78nZbbiTawnTw==
X-Received: by 2002:a17:906:6a21:b0:b6d:7d27:258b with SMTP id a640c23a62f3a-b70700d34b3mr1435687266b.12.1762193912944;
        Mon, 03 Nov 2025 10:18:32 -0800 (PST)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077cfa966sm1093828666b.65.2025.11.03.10.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 10:18:32 -0800 (PST)
Date: Mon, 3 Nov 2025 19:18:31 +0100
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 00/23] mm: BPF OOM
Message-ID: <aQjx91L6IlG-qtjX@tiehlicka>
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <aQSB-BgjKmSkrSO7@tiehlicka>
 <87ldkonoke.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldkonoke.fsf@linux.dev>

On Sun 02-11-25 12:53:53, Roman Gushchin wrote:
> Michal Hocko <mhocko@suse.com> writes:
> 
> > On Mon 27-10-25 16:17:03, Roman Gushchin wrote:
> >> The second part is related to the fundamental question on when to
> >> declare the OOM event. It's a trade-off between the risk of
> >> unnecessary OOM kills and associated work losses and the risk of
> >> infinite trashing and effective soft lockups.  In the last few years
> >> several PSI-based userspace solutions were developed (e.g. OOMd [3] or
> >> systemd-OOMd [4]). The common idea was to use userspace daemons to
> >> implement custom OOM logic as well as rely on PSI monitoring to avoid
> >> stalls. In this scenario the userspace daemon was supposed to handle
> >> the majority of OOMs, while the in-kernel OOM killer worked as the
> >> last resort measure to guarantee that the system would never deadlock
> >> on the memory. But this approach creates additional infrastructure
> >> churn: userspace OOM daemon is a separate entity which needs to be
> >> deployed, updated, monitored. A completely different pipeline needs to
> >> be built to monitor both types of OOM events and collect associated
> >> logs. A userspace daemon is more restricted in terms on what data is
> >> available to it. Implementing a daemon which can work reliably under a
> >> heavy memory pressure in the system is also tricky.
> >
> > I do not see this part addressed in the series. Am I just missing
> > something or this will follow up once the initial (plugging to the
> > existing OOM handling) is merged?
> 
> Did you receive patches 11-23?

OK, I found it. Patches 11-23 are threaded separately (patch 11
with Message-ID: <20251027232206.473085-1-roman.gushchin@linux.dev> doesn't
seem to have In-reply-to in header) and I have missed them previously. I
will have a look in upcoming days.


-- 
Michal Hocko
SUSE Labs

