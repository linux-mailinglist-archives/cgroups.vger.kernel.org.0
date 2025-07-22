Return-Path: <cgroups+bounces-8867-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF9BB0E3AE
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 20:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E0E61C22DBC
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 18:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885192836AF;
	Tue, 22 Jul 2025 18:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G+tPlFFP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6643283155
	for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 18:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753210193; cv=none; b=k6Y6yE2byeCEmWEp9csnmzcv7ecLZhcdVH/WN4Lcvz3vIHsGI0PeF7Gkd9UIh4CrmOzn7F2KfwfvrdMc/FWfa42LGTcQenlaR7BbQnSppnW68Q1dBPmjhVGGMzNFgZucxN6UllT3sGV/D32Yhuwqdiy98gZV5GbtlB1JLEOPMVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753210193; c=relaxed/simple;
	bh=7ij9NpRt80LPFL8HR8TfaqnbnPFxl5ZU4S5TEV5tdZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QyJQlhqQt39FVcPeg19eOPPx7tclX9/y+2GuwP7wEJmsZoeKNGla+FFq4zq4mJpcLPyNklbY1U3aAc5h2+vysQeMauadtrH+ivNDMK3+qYtg1MfPgyik1Ch+dSLLb5/02toQ4N7XyiNvw4wxKIoMq2HJM3jrXB1HAwBO6nUlZlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G+tPlFFP; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b26f5f47ba1so4732205a12.1
        for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 11:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753210191; x=1753814991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbmC//gG5YMMT+YnkzJjaAohtCxkf2risib+NKHtOrg=;
        b=G+tPlFFPbOzd/54LrUVc3UHsyza+oZ28wxHv7mv9o1DON7FwWMUn4LN6eGoiVQf6Hc
         AcxrdeSI+Oz0fTWBx0LCZ+BYEETsslWDvbfqmaVxL4oB4lRXRW06VqLmIeTjzgyRbHmt
         MGlDK0q2tECjugHt3Z8Y1l2TQGMaXijx32tu3+0dEKmioC2EoYOn5TII4UNd+bBBT0HO
         74zVF+FrDNA+evCVTqNOSmCQ9qJSsfH//l5rbTrjpoRYsBhClkFDaiCrExw/s+EuolcW
         +kEF8AVlFUH8JacmFFJz5smmHr8GZe2jIYiK1Be/011RwQDc9Q76KHVkAmuatiJSmBjB
         twBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753210191; x=1753814991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TbmC//gG5YMMT+YnkzJjaAohtCxkf2risib+NKHtOrg=;
        b=hnKX8808zAnUtwe6E/3EHuNLe2RDRBXx0jK40fn+Zf8Y84oUPDF/mufC0JuEj7PGQX
         bgQIaQjewT4WikSYfCmch+zk8EEWvs/AImKXXOW8/i/nAaYwGLB24hi6danuni85DH1g
         LlQNCQasUyo4ZWTLWHHJsE9dLBDygGgiqbw8S4RIZrPMziZGAYM7d0LjiKXX/u68ixOC
         Hxi4OlBxiqV8NNcDscZCXh2x8mGrLqNMBdzRx66F73FinXDChv6rm1xDS8ydcDNoQKiz
         uLh6oDhLY5zDkEQZpT4nL/hCG8NNc28bwwDqRZ9hDi5aYp4yAkMKKmgDom0EJwH8B6Ye
         GCdw==
X-Forwarded-Encrypted: i=1; AJvYcCWEk1t3BN8kS0DJWq23l99XvGrz2XkjmRx+ytNmJbfa+ROkzLl8ArXgGS0Psb3wxHxqrx7wfwWq@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv3japPnz1pd0ddlPeAzmsvsHq9j9gKVCPmOeuWVMUTHUAv+bV
	9jZVMAbROK3qakUAKWbOivBbqROBVxNKwyWkV5X5nsk24f3QPEucPBdaDCb9pAd4o7FPW0fOhAW
	NUT3fvki5Ou6l3C5wAyb8ElVVZaYd3UKd28/EDZLg
X-Gm-Gg: ASbGnctnVijupD1W/eBFBgm/HyHA9fujMmelXdYyD6onlJi7o1UFgnupisVo8JJaEhV
	MNygsnX8FdwEuKsnTX0iEF0yEhAEREmFEr8xiGBne0rmscYToF8tEbr67sHZhrGGMXqEinwPG7f
	tTQOu9stt1gDQo4a+mPBKG3h55Q9919d+3XMXfkBenf3J/+mQRPNX3kxEL+hSX941HNtHVJEDHT
	Tqt8/JKsav+zgnhk7x5CdhNaCMf2lSBg2jVFKnancnAvfIH
X-Google-Smtp-Source: AGHT+IEg4W97E07D/JlFeehtaiwxPWUF4AnFa19XV+i75fU3XCe4tqE6HcJMrlHWpbyEhBQz5BtcSmGxO+C8g2IB2zw=
X-Received: by 2002:a17:90b:388b:b0:312:ec:412f with SMTP id
 98e67ed59e1d1-31e506ef9afmr612863a91.14.1753210190763; Tue, 22 Jul 2025
 11:49:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722071146.48616-1-daniel.sedlak@cdn77.com>
 <ni4axiks6hvap3ixl6i23q7grjbki3akeea2xxzhdlkmrj5hpb@qt3vtmiayvpz>
 <telhuoj5bj5eskhicysxkblc4vr6qlcq3vx7pgi6p34g4zfwxw@6vm2r2hg3my4>
 <CAAVpQUBwS3DFs9BENNNgkKFcMtc7tjZBA0PZ-EZ0WY+dCw8hrA@mail.gmail.com> <3db01bc9-f6ea-41f7-8cbf-fb33e522694a@redhat.com>
In-Reply-To: <3db01bc9-f6ea-41f7-8cbf-fb33e522694a@redhat.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 22 Jul 2025 11:49:39 -0700
X-Gm-Features: Ac12FXyhexe6ErD4K44AhQAu2qUuwklTJsSiRV2SdD5og77T3xQkMML2F4JwTjY
Message-ID: <CAAVpQUBgDVHwCzw_UJBeh_SLf=w547fKy9v-ke_Rw7Q-C4rhhg@mail.gmail.com>
Subject: Re: [PATCH v3] memcg: expose socket memory pressure in a cgroup
To: Waiman Long <llong@redhat.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Daniel Sedlak <daniel.sedlak@cdn77.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, netdev@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	cgroups@vger.kernel.org, Matyas Hurtik <matyas.hurtik@cdn77.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 11:41=E2=80=AFAM Waiman Long <llong@redhat.com> wro=
te:
>
>
> On 7/22/25 2:27 PM, Kuniyuki Iwashima wrote:
> > On Tue, Jul 22, 2025 at 10:50=E2=80=AFAM Shakeel Butt <shakeel.butt@lin=
ux.dev> wrote:
> >> On Tue, Jul 22, 2025 at 10:57:31AM +0200, Michal Koutn=C3=BD wrote:
> >>> Hello Daniel.
> >>>
> >>> On Tue, Jul 22, 2025 at 09:11:46AM +0200, Daniel Sedlak <daniel.sedla=
k@cdn77.com> wrote:
> >>>>    /sys/fs/cgroup/**/<cgroup name>/memory.net.socket_pressure
> >>>>
> >>>> The output value is an integer matching the internal semantics of th=
e
> >>>> struct mem_cgroup for socket_pressure. It is a periodic re-arm clock=
,
> >>>> representing the end of the said socket memory pressure, and once th=
e
> >>>> clock is re-armed it is set to jiffies + HZ.
> >>> I don't find it ideal to expose this value in its raw form that is
> >>> rather an implementation detail.
> >>>
> >>> IIUC, the information is possibly valid only during one jiffy interva=
l.
> >>> How would be the userspace consuming this?
> >>>
> >>> I'd consider exposing this as a cummulative counter in memory.stat fo=
r
> >>> simplicity (or possibly cummulative time spent in the pressure
> >>> condition).
> >>>
> >>> Shakeel, how useful is this vmpressure per-cgroup tracking nowadays? =
I
> >>> thought it's kind of legacy.
> >>
> >> Yes vmpressure is legacy and we should not expose raw underlying numbe=
r
> >> to the userspace. How about just 0 or 1 and use
> >> mem_cgroup_under_socket_pressure() underlying? In future if we change
> >> the underlying implementation, the output of this interface should be
> >> consistent.
> > But this is available only for 1 second, and it will not be useful
> > except for live debugging ?
>
> If the new interface is used mainly for debugging purpose, I will
> suggest adding the CFTYPE_DEBUG flag so that it will only show up when
> "cgroup_debug" is specified in the kernel command line.

Sorry, I meant the signal that is available only for 1 second does not
help troubleshooting and we cannot get any hint from 0 _after_
something bad happens.

The flag works if the issue is more consistent or can be reproduced
and we can reboot, but it does not fit here.  I guess the flag is for a
different use case ?

