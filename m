Return-Path: <cgroups+bounces-8327-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B906AAC2691
	for <lists+cgroups@lfdr.de>; Fri, 23 May 2025 17:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C21F13B5997
	for <lists+cgroups@lfdr.de>; Fri, 23 May 2025 15:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAD8246798;
	Fri, 23 May 2025 15:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DYNG3rqR"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C374523C51B
	for <cgroups@vger.kernel.org>; Fri, 23 May 2025 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748014600; cv=none; b=sYCZcKwBTUhDR2rlJAu5PANVb68iOPRRf4jMVOAKDz1mRyr3Xt4nAiif1CCHoCvHoWiL4X6CVrhTF814zXlgV5wSUvoz9b1oTa4LUqspZxkbJZP5ZKLuWYZ5Hs32ymh+7LgxT3pgDx3ED09I6hOye658TOGhw5Vw7DWdeoURBXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748014600; c=relaxed/simple;
	bh=mBoyiUX6cNGmBI/RVAoVtGY+TJHKe8LjzoZW8vjRCY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LLw5Z3KnFIctxS2oZm0DIgHVzzwNN1Tc4mrll3wifpZEXc3vuuMZmg+XNnj1uRfVgUB8fT6MS0oiy/HZo/oDbqFk6wUuToh60YcysL2BMBAYqjjpQeKltgVUgktckNsBoVBuwfg4FjBvrPDd6NtZqf9q3wUKbF8vEy8ns9fp9Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DYNG3rqR; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-550edba125bso8018240e87.3
        for <cgroups@vger.kernel.org>; Fri, 23 May 2025 08:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748014597; x=1748619397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBTug0/NeMZd6Qk9EUzJxCkzpzI4b0/AjBa3843O+Gk=;
        b=DYNG3rqRk8pJAfG7sGnOkJsid4jRlus793Hi4KqUHsbwV+4rcsggO3l24pEmtnR4DO
         OG31/RC/GJFuByJjRT7LaEP+OYr2NHJbrD4pj5qCoPHTKLPY6xTnO7u+SD278QpEItcC
         9ic0RaLFG2WidDn6y/IHAN5XrhG5Nt+aw+zBs8GJSUGAd7c4WfsNv5EbbCEGkNm6LBnn
         R0Ete8dTFqIZncVrz06rI/n/UAbu6EgsttL6byxJs1SPUbUOL4uYDePC7xuRmGWDC7qi
         xCkFwaccDk97wPEnnNtUaxiNi85JklHiJUTe1T01yMR9stTegBgN5BmAzzwZ5vKxhBXs
         jzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748014597; x=1748619397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBTug0/NeMZd6Qk9EUzJxCkzpzI4b0/AjBa3843O+Gk=;
        b=My2aD35IB66NAukMC4r2hBDPnQ9hx2nvNHcVelXly1dNInfy6bAsJ6TeG3qhXN0Gf0
         BwhjZBLgVzvxpF8A9oDHUVbrwfh25MxTNNgyfL2sP9BICDl17JvfNnjOeutPh3YGfZZ0
         t2dVthLAtoOnucFZ/F92nIIZIFcIX+YjCTUNoA+qZQOqsBmp7qiSD5A1NQ3V6hhH/jxY
         fe1Hmr4xb5046NIwleOvd7bfH249F6YI3a/vnlJvGkE6c6q65ieC9wAo3EJfWM9VmtZg
         m3Ntp9f1pGLPvxBeHhSFwPg8tIiKLMto5gK7rDeiiHeqI5n4uAwVkbXmQYdjgZrkigec
         L6UQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnuacXX14kt71d+c2DOI0tlHVu/gMF6MCLg8hMsX+7XatLfzcz6uTy8nGnFKDQQQvwYJlhQMQ6@vger.kernel.org
X-Gm-Message-State: AOJu0YwOnRpgbYmHZylKSvrdmBJ3YFiG1r/x1aBIygv5+arctM5vym9p
	bAW8k8KHCJwI9uxo5RNA/VGimKsOKa6rvMiGFeFDWQf07Vp2RKSlfPen0i05OpLu6tttcl8J9Qu
	aYYyxIy0lsvR2JTzO6wK1hlDxW5Ufc/xchQ5+3Nddsw==
X-Gm-Gg: ASbGnctrlijJA7iT8c44KL7DxgYdn95Z7EWc5xoz/rvas7SAazttJniYxDMDGwt79uI
	hoHbTl5jmmSNI7FHUliVwi+9WoH5Ox8zXK3t1HGN59xBkHEmssRR/pdKMpeymvUyF0IguKkhlBA
	JoG+M8hT77IeGaNG++B70WgJfqz9ya2ybDS3k=
X-Google-Smtp-Source: AGHT+IHAij+IkAtUHU5WlmmWLtmmWgHF+NpmCZ7ttFYGpc17RlUZBN41Ag3XoQmzFn5988CXaFljyU58oThRKVVdiT8=
X-Received: by 2002:a05:6512:650e:b0:549:8cbb:5443 with SMTP id
 2adb3069b0e04-550e724a21emr9751477e87.47.1748014596646; Fri, 23 May 2025
 08:36:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520031552.1931598-1-hezhongkun.hzk@bytedance.com>
 <8029d719-9dc2-4c7d-af71-4f6ae99fe256@redhat.com> <CACSyD1Mmt54dVRiBibcGsum_rRV=_SwP=dxioAxq=EDmPRnY2Q@mail.gmail.com>
 <aC4J9HDo2LKXYG6l@slm.duckdns.org> <CACSyD1MvwPT7i5_PnEp32seeb7X_svdCeFtN6neJ0=QPY1hDsw@mail.gmail.com>
 <aC90-jGtD_tJiP5K@slm.duckdns.org>
In-Reply-To: <aC90-jGtD_tJiP5K@slm.duckdns.org>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Fri, 23 May 2025 23:35:57 +0800
X-Gm-Features: AX0GCFt0sS7VYPB52zeUI_3_ZpYBGiasCDtLJweGgJzUP78rp8YvdTmx5WfX8CE
Message-ID: <CACSyD1P+wuSP2jhMsLHBAXDxGoBkWzK54S5BRzh63yby4g0OHw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] cpuset: introduce non-blocking cpuset.mems
 setting option
To: Tejun Heo <tj@kernel.org>
Cc: Waiman Long <llong@redhat.com>, hannes@cmpxchg.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, muchun.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 3:03=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Thu, May 22, 2025 at 11:37:44AM +0800, Zhongkun He wrote:
> > > I don't think this is a good idea. O_NONBLOCK means "don't wait", not=
 "skip
> > > this".
> >
> > Yes, I agree.  However, we have been experiencing this issue for a long=
 time,
> > so we hope to have an option to disable memory migration in v2.
> >
> > Would it be possible to re-enable the memory.migrate interface and
> > disable memory migration by default in v2?
> >
> > Alternatively, could we introduce an option in cpuset.mems to explicitl=
y
> > indicate that memory migration should not occur?
> >
> > Please feel free to share any suggestions you might have.
>
> Is this something you want on the whole machine? If so, would global cgro=
up
> mount option work?

It doesn't apply to the whole machine. It is only relevant to the pod
with huge pages,
where the service will be unavailable for over ten seconds if modify
the cpuset.mems.
Therefore, it would be ideal if there were an option to disable the migrati=
on
for this special case.

Thanks.

>
> Thanks.
>
> --
> tejun
>

