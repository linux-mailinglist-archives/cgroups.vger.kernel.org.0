Return-Path: <cgroups+bounces-3732-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C01933FE7
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 17:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1FCB1F24BE8
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 15:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18F2181BBD;
	Wed, 17 Jul 2024 15:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Bg94WuGM"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A81418133B
	for <cgroups@vger.kernel.org>; Wed, 17 Jul 2024 15:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721231209; cv=none; b=mv9afDTGFRt8SJxCknzMsH7h/othn5oypxx74p8WG12W6cfLyOCgyUjkcHYxX3AhYqpzZ/p5Gh32oYEP8k3LLG7uyXLamxSIx7xYDi+wrGF7Mjs3IbV4THHOYkltKcx/Fan8tPLIjAmPVdHmIDlDvTsucsIZzeImj4m6y21f2hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721231209; c=relaxed/simple;
	bh=kJgkL+2m1Xq6q5a/7T1ZCG+n4LTBHOKoBqX/2MsLU+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oalcuav1ka5LtSGzrcogKyfjFjEy3MMvkj+RcPJSHjJTuwekCRGxx8jU/R82n2DdKOphsvFYsZqPI50zX5PY3jAZwS+VB7fOFnEmJnk16bd4iWI6stzFoXPlZ/KHWk3mvZy6gJBXwwfima8bYOiQ6g7cSJH/A2JE0RY6qQBe4c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Bg94WuGM; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-58be2b8b6b2so8341913a12.3
        for <cgroups@vger.kernel.org>; Wed, 17 Jul 2024 08:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721231206; x=1721836006; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=itVRxRQ4fgSvCkmp4ZT/tO0ArO/vcPF2tBOypwTVJTY=;
        b=Bg94WuGM20J0Lde2Xjz9cuG3NCP+KT56+akNY5U1XQHGnz5+XT7Ry40ysRHeGpbQQX
         ixl48g7QXWEOQYcs8yOI9F/b82A33Nc6lA2PvLao/L03lQqUtm1KbRIDVPWCiVHgSAFk
         hxXQ9mgJEZPtUcWs0gPA7xZWfEX7fz2yS97t5oMtMj2tt0A3Lu0VoSk/eYWVrIdBT3BM
         hVZmGd+4+w89TNlPdzb/i7RVPVSFV2cMXsnfGFko1sK9JcEa+mnMfwoOfj6RFdx6HQlo
         05LlUVpajXScvc/M9mIs1E1Q+3f/tna8B3y+G59gqh/M5qDzRSnfaq2WXRif/rU2tKLY
         IhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721231206; x=1721836006;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=itVRxRQ4fgSvCkmp4ZT/tO0ArO/vcPF2tBOypwTVJTY=;
        b=ARN4qIa2BctAbWqG6CK8ymEmupzrRisGHEiaSsOtLump/SLPUdzUaFm0Ek+B8Q0PEE
         j7LkMsWHxE6pqhpiN1ndbXj5RsaaKlusVpb9GuMo32dojQrpBD+Ky6MU0222BQrFZGm1
         nf6qFfRTUk1iRQnwc4M5tOEyfaci8FOvgOu2nsJ0qaz7P5O4cMhZ32Z5Own8ikxtbbIU
         GWb+p2LO79J1uBjIR0sb/4q9scNwSUOX/sKvLhfE5y40mi1ZVlpHmYWjTrxwlFqwJheG
         vICxn+Eot867e148fRX8HE+zmaCSMKGkcFUly3X7TIbhnCNwxOefIxB0ZyNbWkVq+uCC
         FF/w==
X-Forwarded-Encrypted: i=1; AJvYcCXaWouqBRIQ9ROjJlr2Q/bwyXo82VcOgGbI97vjhJUWkmQvmpEhQ9ZUEvCvjnxeaCMWwslEy26pOxL8/6zDFtEICnbBV68sLA==
X-Gm-Message-State: AOJu0Yy12gOZBU1V8hWGw96ssSRy/7CcTDARVmLkhRVCh2374ht59r09
	DzeOYCYB59DzqKbPGJ1bKYJF5Inivox0Lv88NClrMiF5EbOyui9L0UUdCchh85c=
X-Google-Smtp-Source: AGHT+IGS8IY18QSmrzGhSf+9nBg/8OXqPmS/hfbRyHNmZ0PhqQ2RvzORNPd8rwXPBcuIP3heqkOwVg==
X-Received: by 2002:a17:906:79c4:b0:a77:da14:8403 with SMTP id a640c23a62f3a-a7a0111619cmr176072266b.2.1721231205823;
        Wed, 17 Jul 2024 08:46:45 -0700 (PDT)
Received: from localhost (109-81-86-75.rct.o2.cz. [109.81.86.75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5a3a93sm460671166b.6.2024.07.17.08.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 08:46:45 -0700 (PDT)
Date: Wed, 17 Jul 2024 17:46:44 +0200
From: Michal Hocko <mhocko@suse.com>
To: David Finkel <davidf@vimeo.com>
Cc: Tejun Heo <tj@kernel.org>, Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, core-services@vimeo.com,
	Jonathan Corbet <corbet@lwn.net>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shuah Khan <shuah@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
Message-ID: <ZpfnZGWuOsIFPUWE@tiehlicka>
References: <20240715203625.1462309-1-davidf@vimeo.com>
 <20240715203625.1462309-2-davidf@vimeo.com>
 <ZpZ6IZL482XZT1fU@tiehlicka>
 <ZpajW9BKCFcCCTr-@slm.duckdns.org>
 <Zpa1VGL5Mz63FZ0Z@tiehlicka>
 <ZpbRSv_dxcNNfc9H@slm.duckdns.org>
 <CAFUnj5MTRsFzd_EHJ7UcyjrWWUicg7wRrs2XdnVnvGiG3KmULQ@mail.gmail.com>
 <Zpdj-DVZ5U5EdvqL@tiehlicka>
 <CAFUnj5OxBSVJjjsSA1E58K4F1GH_P7tYKfpMmtFrNtGgEkngtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFUnj5OxBSVJjjsSA1E58K4F1GH_P7tYKfpMmtFrNtGgEkngtw@mail.gmail.com>

On Wed 17-07-24 10:24:07, David Finkel wrote:
> On Wed, Jul 17, 2024 at 2:26 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Tue 16-07-24 18:06:17, David Finkel wrote:
[...]
> > > I'm thinking of something like "global_reset\n", so if we do something like the
> > > PSI interface later, users can write "fd_local_reset\n", and get that
> > > nicer behavior.
> > >
> > > This also has the benefit of allowing "echo global_reset >
> > > /sys/fs/cgroup/.../memory.peak" to do the right thing.
> > > (better names welcome)
> >
> > This would be a different behavior than in v1 and therefore confusing
> > for those who rely on this in v1 already. So I wouldn't overengineer it
> > and keep the semantic as simple as possible. If we decide to add PSI
> > triggers they are completely independent on peak value because that is
> > reclaim based interface which by definition makes peak value very
> > dubious.
> 
> That's fair.
> 
> My only thought is that "write any non-empty string", is a very wide interface
> to support, and limits other possible behaviors later.

yes, that ship has sailed long time ago.

-- 
Michal Hocko
SUSE Labs

