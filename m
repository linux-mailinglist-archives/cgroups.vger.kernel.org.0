Return-Path: <cgroups+bounces-5386-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 498B59B9973
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 21:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BD1F1C216F6
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 20:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890901D89E9;
	Fri,  1 Nov 2024 20:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/h2MROr"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55F11D130B;
	Fri,  1 Nov 2024 20:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730492941; cv=none; b=pKTvfG8wxDq1pqyAxKYygYjWbEli26D422Ga8tRBq0+GL93rBmIJXfuH2ydn1q4V9qik69jh6oH4U85g27zkQuVdygG1seM4j1KP0SUx1IqUhMcLxvStxiFhaN/L0BUacA3rUbGKx7G7cAjzlQVLBKmuccl+bn/QVsUY0R0n6Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730492941; c=relaxed/simple;
	bh=S9cfwILXO32C5TwGWUGXZeM/efRRFcB8OjLfIcHNCLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hmWkI5NrV5Y9gNEb5JYirDUwUML6HVTi2+ZaJcX7dS7dsSjXb14MbZVDe9j8WJGTRr3h6IkaufitXy1mPRsKdIjVUwbUtyyNr1PylXvF6nYnnI2FkQPS4xz3esmz3jNBpr7ZlbxSREb5gUxzsuWzw0hMgJvjwjWeLY/iax8aVpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/h2MROr; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c948c41edeso2829632a12.1;
        Fri, 01 Nov 2024 13:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730492938; x=1731097738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9cfwILXO32C5TwGWUGXZeM/efRRFcB8OjLfIcHNCLM=;
        b=C/h2MROr4VhtBzD0Ys7QJWrHsiSVILheFVIyinMVV9/Fgg6CljMBXeLAkBo7oSP5me
         3crgFNUUit1b9K9vYWHcLYGq7GyXvUdEJ8AvqBJiir9/EbA3lCJ8D2plJu/oKSNkCbIB
         +oZ6rTNv5ugnUGGM35Il9clhK8gZFGZlR7yovNvIISUCAUQaIejC39a6xmAAtx0zslB+
         3gXlWIKYyAquQAcJctoPsdQlNKHsos0zXt7VoPQwc2CBNXp7XTeio5ZMCh+0Rm2Hfb5p
         zNpsa8SgjHrQ2IxDONVf+JXtZrkS6q+rPfEgXzHZbDIS2wNS8wTTUpKVuOpdySKDPa6y
         dI0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730492938; x=1731097738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9cfwILXO32C5TwGWUGXZeM/efRRFcB8OjLfIcHNCLM=;
        b=f5q6DYx7J79BUJx6KAm2V7+2sufdau5d5c3V2T+zr7SH/hykmuC+lLIYBR8FCJoxrz
         9hwtsSqrDeW7cR6YTZGZawqnadG/qANq8Muz263Bm1C/wBhohIb9MsYpCfsGqoyupYq/
         ndFwSydCUDRcDJzCMzv+ac6AX3z2oYjo8pF1jpqvakextSEeqszwC3jmev+/lwvsL1Nv
         uPmoqxmx4K0v20KJ9btLqAyCHBshbN8hsnItxOtHq5ZSbzNbktxZD6SZYpWetL/d09Na
         32LBwTUVgeGGEJRoatDKrgH+oUtousIh6FpjvEwf9zPpf+WhSisKYT3MLMdSCCliZLMk
         7Nkw==
X-Forwarded-Encrypted: i=1; AJvYcCUSPVB+N08zNbdl7jKCVJsn0Cc6CuRF7Cn3oca7zZE6d3TjfUTxfizu9XlUxeJykklg8UFmnm52hWVR@vger.kernel.org, AJvYcCW0PHMIb26HOqM0S7h71wQDLp+9c4RNA+NVDQkiaR8Y3CsbxoyNGg6qGtWwGzJYdCTucz7QjaDhJN7bgbW4@vger.kernel.org, AJvYcCXjseuJyApGnoVnZwWVvUx6ZFM2dGrg64EIPxmcjwAkLaRrm8U7nygS4nskP9i+rhYR7dvhQLzu@vger.kernel.org
X-Gm-Message-State: AOJu0Yx03snVb+bDaefsLY9R4ivLDV2rgWVGj0MP5HA6I1XJylFOqWZu
	LurqUrp+/V4fcj8STCL/Y+ScBEnEoeIPk4Fyb//VgNCvcquL2CI30wWg4yCfPK+7JMQzAnCfFFN
	l2z52wpi7h13CpECdpbW+IiToitY=
X-Google-Smtp-Source: AGHT+IE8JAu6BklyDKpqhk3H5YsU17ektfFuySsuthxrul4lrnEixM60HMkCiYDUCJahH0PkP/o+qnAR634MMyoW4UE=
X-Received: by 2002:a05:6402:274a:b0:5cb:6b86:82d with SMTP id
 4fb4d7f45d1cf-5cea974e30fmr7243311a12.36.1730492937802; Fri, 01 Nov 2024
 13:28:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028210505.1950884-1-joshua.hahnjy@gmail.com>
 <ZyIZ_Sq9D_v5v43l@tiehlicka> <20241030150102.GA706616@cmpxchg.org>
 <ZyJQaXAZSMKkFVQ2@tiehlicka> <20241030183044.GA706387@cmpxchg.org>
 <CAN+CAwM1FJCaGrdBMarD2YthX8jcBEKx9Sd07yj-ZcpDxinURQ@mail.gmail.com>
 <ZyM7_i1HFnFfUmIR@tiehlicka> <CAN+CAwMioguv6itTSYVUO9__kQVv6HZO2-i0NWt10-x7f6JVSQ@mail.gmail.com>
 <20241031183413.bb0bc34e8354cc14cdfc3c29@linux-foundation.org>
 <CAN+CAwORE8+P7Td9yebkb0TVT92SZv8oasrypewCspf5om1fYQ@mail.gmail.com> <20241101130249.c065324ab9927ac3a61ffcb0@linux-foundation.org>
In-Reply-To: <20241101130249.c065324ab9927ac3a61ffcb0@linux-foundation.org>
From: Joshua Hahn <joshua.hahnjy@gmail.com>
Date: Fri, 1 Nov 2024 16:28:46 -0400
Message-ID: <CAN+CAwPH8Kz6VLX7F44=P6X=y_d_DLL0KvdWFDJD5yiE_7-_ig@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] memcg/hugetlb: Adding hugeTLB counters to memcg
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, nphamcs@gmail.com, 
	shakeel.butt@linux.dev, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	tj@kernel.org, lizefan.x@bytedance.com, mkoutny@suse.com, corbet@lwn.net, 
	lnyng@meta.com, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 4:02=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> I think it would be best if you were to send a new version of the patch :=
)
>
> And while there, please make the title "memcg/hugetlb: Add ...".

Hello Andrew,

Makes a lot of sense to me : -) Sorry for all of the hassle! I'll send out =
a new
version shortly. I hope you have a great weekend!
Joshua

