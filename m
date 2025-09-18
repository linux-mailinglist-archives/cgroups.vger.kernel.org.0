Return-Path: <cgroups+bounces-10223-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E133EB82A6C
	for <lists+cgroups@lfdr.de>; Thu, 18 Sep 2025 04:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B3DE722C84
	for <lists+cgroups@lfdr.de>; Thu, 18 Sep 2025 02:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E766523816C;
	Thu, 18 Sep 2025 02:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bIY0ByO4"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCFB1C2DB2
	for <cgroups@vger.kernel.org>; Thu, 18 Sep 2025 02:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758162457; cv=none; b=Eo6S7F/lBxKa5ooUUMBqb05hgc1HJ7v7sCwozUT7BPZTHbOctV8HvYXf9BZliboINHzLYkl21GwjSjbVx7TlCjIhyg0z4G+IQBTPwJ0oGdBC8ZNVOw18yOP3/yPmg+ZSL0QhNm5vHXhAzNVDte2qz0W2Jta8M5GtH72Ri1EHy6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758162457; c=relaxed/simple;
	bh=r9V7rNKrY7xZaCviRdGUntwSbscNJK+MdfAJKfrHACQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sOhKkFNz1P2Ih78oQ22N92yg8K5BhpK4AjEy1dE/6N7weGb3drpBgSmwnbSuDDRvWM69Gt2hP+K+xYpVu22CuXq//09CQpCRxw7qIVu9v4fE42tmRyOw5Yo92oGL4TTYE4415Tje9hhhvZ8eABrBhJ0qgqj/KcQm/B2Da95DURY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bIY0ByO4; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-71d60501806so4072877b3.2
        for <cgroups@vger.kernel.org>; Wed, 17 Sep 2025 19:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758162455; x=1758767255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFrjr7oI44As9mOdavnrOAOtlOzT/S4ln2vJMFz/Qt0=;
        b=bIY0ByO4Z70MJJuthEVmWXfJBJrlIvs89XjsYP6+jafl6mlb9AqoWduKJPK/94n1Jh
         aLZ4x6sau/LSI4Tl8deTRTs/+4qtX4OpbbN3AXfNlJhC3SNM3H55aAOMuPOFW8HNBDfr
         UV8KDVfdM1q5CdhFekEWWAnA/XaOFqWXqp5nDTckCYJ6WXoFAcbnKlRtFrLmrSKJs8r8
         d6sXGfA//UVKiJO4L8JUxtcbyu8Vz8mu7HG9zay7qKsiwYI8TCpVDRCG/N8Vmk5K8khS
         frFVdHSTU2FOfmozxzFwzCMF+pJXTUQVslu34fP8LJIkA+xiIj0AV7p3aMKgnoRMGsI7
         vW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758162455; x=1758767255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFrjr7oI44As9mOdavnrOAOtlOzT/S4ln2vJMFz/Qt0=;
        b=JYv00of08OgPteifTg6a06kreXhFjGiH+pSYC9E9XnIw7wAl9a3JHRw1BdqwZHgJN2
         Bwy+/N6p7K9zOyFS7c10QZjXVJivNQIzBr02qK65P7cXTeB4m782tBZff+aA64V1w8TY
         vi8DfXKVdYV1ATZ6y59/5IZoNFjMfn6gt8i9MtrgJknlsT+NOxG1BDBLRVJ94n8W4QVw
         LGZ5RS8USJ1GEof8w3/BfcADI5a1Bm6+MUnh7t1N3vLweHoby7d7XtUzaVIkXsIBUJvu
         1Ac/wfRTnKyrtzkxK0PzISs61lovMqAo+4wWDtCferXtNA7N9eJEWiAmYyoK97kx+KNp
         bjew==
X-Gm-Message-State: AOJu0Yw4Au4dqU7/pWxmlNyok0lLsZbQ1OXakkpbNxHHU4ec8dhDkxo5
	EgYV+xhGujHMxsxuEjQ4pJuURtfJxmclfDdece43LC14u6HCrrVl2h6dSOLHSCz1JCk1O05LqdY
	oX8sJVqWkwGm7QOiPCA1Gb3MFae1Jq4Cr1j81S970nQ==
X-Gm-Gg: ASbGncs+t4w40vT1uvCyKQCfccY29qgGpe8JZeULBcHmx7Zz9EPxCq8gclatEaJNHuZ
	T3oNFEERuLWcTvdYAr4sdkhgfeShM4du3vgOvygIwxW2KNdO4Ff/tEKFr2CRs/sWzWwtvE7A2aB
	0LywN/4IVPPqIPAF5PkAGmFcKHwXB+Ct0sKlXQ2OEjBTOt7EnLTwdcp4pniG3ZIKKnkLa/zsW+m
	zhPRu3ZwCM4j6k7T2/OqKjVlPt5TKvxFWCwMPklUjv4yQ==
X-Google-Smtp-Source: AGHT+IHr9JgnFjpeT/zNs9L7BOU9gS2fjyMz5QFUAEpR4RhWUaYl+0KPaeqk8mPlazZxDIMzmM/v0qD8tnH69VyiLAo=
X-Received: by 2002:a05:690c:6f83:b0:72c:bb8e:3d70 with SMTP id
 00721157ae682-73892a45ec8mr44504117b3.47.1758162454739; Wed, 17 Sep 2025
 19:27:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917212959.355656-1-sunjunchao@bytedance.com> <aMstLw_ccoveLow-@slm.duckdns.org>
In-Reply-To: <aMstLw_ccoveLow-@slm.duckdns.org>
From: Julian Sun <sunjunchao@bytedance.com>
Date: Thu, 18 Sep 2025 10:27:23 +0800
X-Gm-Features: AS18NWB5MaYCMMqfKrJS9g29_klveZt2uzpxurqlqJahQN9eqVnilHG-fNbZMeI
Message-ID: <CAHSKhtccroAB_MJ-Dz0KgKgZEOfMdqdtZZq428tULMBv2hU4=A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v6] memcg: Don't wait writeback completion
 when release memcg.
To: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org, linux-mm@kvack.org, jack@suse.cz, 
	muchun.song@linux.dev, venkat88@linux.ibm.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 18, 2025 at 5:50=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Thu, Sep 18, 2025 at 05:29:59AM +0800, Julian Sun wrote:
> ...
> > The wb_wait_for_completion() here is probably only used to prevent
> > use-after-free. Therefore, we manage 'done' separately and automaticall=
y
> > free it.
> >
> > This allows us to remove wb_wait_for_completion() while preventing
> > the use-after-free issue.
> >
> > Fixes: 97b27821b485 ("writeback, memcg: Implement foreign dirty flushin=
g")
> > Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> > Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
>
>   Acked-by: Tejun Heo <tj@kernel.org>
>
> Minor comments below:
>
> > +/*
> > + * This structure exists to avoid waiting for writeback to finish on
> > + * memcg release, which could lead to a hang task.
>                                            ^
>                                            hung
>
> > + * @done.cnt is always > 0 before a memcg is released, so @wq_entry.fu=
nc
> > + * may only be invoked by finish_writeback_work() after memcg is freed=
.
> > + * See mem_cgroup_css_free() for details.
> > + */
>
> I'm not sure this gives enough of a picture of what's going on. It'd be
> better to expand a bit - briefly describe what the whole mechanism is for
> and how hung tasks can happen.

Ah.. I think explaining how hungtask occurs is a bit too detailed and
verbose. If readers want to learn about more detailed content and
causes, I think the commit message would be a better choice...
>
> Thanks.
>
> --
> tejun


Thanks,
--=20
Julian Sun <sunjunchao@bytedance.com>

