Return-Path: <cgroups+bounces-8452-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3204AD035F
	for <lists+cgroups@lfdr.de>; Fri,  6 Jun 2025 15:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13B163ADEAB
	for <lists+cgroups@lfdr.de>; Fri,  6 Jun 2025 13:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1428A288CAF;
	Fri,  6 Jun 2025 13:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkwI0RYP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5AA288C23;
	Fri,  6 Jun 2025 13:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749217197; cv=none; b=kHmFBKUeh0poLBq4vc8Dn3iB/Jfq3D4jMM0npv5HdSym4UAnl17N++3QxYIBLNb1Udk44aImOcL7rHt+xmG32pJCNe2wd4W0K9lShjUYKHeFtxBF1RF90IdpnzJh2d7m0hO8OfDar5mL/w5w42hs3AyvuG0aGXxAKCGGIhsIYr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749217197; c=relaxed/simple;
	bh=kpYBCOWqlcUbNI8U/W5uVMq4kEfwQ6kJSs+hTJoI0Gg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=o8ITaMlrjm3tDL3rTiKctWwxsY33aY1Zv7K+1qlKsLd4A2378z3srd2DrdsqCucYwNg/qvXUcM01JF0SGkzvR970X/jKU/x5pioKju9KnttOzUqE/NJ9Wj1J8PTS229hH5G/15PmwcGP+MuJCu9eFGQH3+mOGiCDQFfN3LMt2Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkwI0RYP; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-74019695377so1406020b3a.3;
        Fri, 06 Jun 2025 06:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749217195; x=1749821995; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0kzSCcm7K1KpCxO5k7+lql1juWpoA+wPJQtkbiIdI0=;
        b=ZkwI0RYPLrQ+f+2/XRKTslWVbNHij+AzJZdksvaCKQ7qZtr0F8AyUED3DnxVCQRF26
         4bS7E1Lt3GxQIcfGx+MNLxF2P1bKPsRqUCCWqYQPKcl9giuzIDipW3qovrCgD4GiEqWY
         4NbBzMqIxb9USdtUFz/m6O2mxs8TDNiNWGZR7GBbUizTGT/kE930OJTDz/08CphKVd57
         XvvB6Vgwf/aBznXVjAD6rGSWi7yfps+J00OPzjNX6Z5JHXdVLML5oj2dcqubXWtqLzJI
         tBXOyhh62mZE2WejbMNhvX5xfl+KWQstVmAAImcoNi7r4kVopr2fcppdps8pLtbyPG8q
         O+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749217195; x=1749821995;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T0kzSCcm7K1KpCxO5k7+lql1juWpoA+wPJQtkbiIdI0=;
        b=Zs563dvnvNqiaFgFitlhNrOz/wn/fC2jgeYL0LL3FbdVTx+kGwOfJ5iWYbJc4zb76e
         iByIbje27i/fkXejs0E20SppzQS1sVa+UCwu7WQg2Rm+kl/4GNlPjoQWG8B/FufBv8Yp
         0Z/Nh7zSzxS7k7+h1WC/dLaFUJ2+WWVEZ5AuMkdoQFXUsb4tK9x3xILj/9+z+GU9CRTF
         JXjYI2D4Ig6SjV92qiZ4bJqoYIZX46PZWLkAAFCJnWEtDYhcZ+8RJ3gT/2FXthqhwg9x
         r75WdqxzEhndHSS6RCZPDJdytuecU2V8sU5n5sQgX2S8WcL9X0dkobdbVhQAj/bEpXRn
         eaog==
X-Forwarded-Encrypted: i=1; AJvYcCWpztSKviYP/ibl2zmrwIlNA8lW4eCcFL47W+nNneX6V8PjkyI0Vd2MKOkaOzXjzTeSHLx34LSC@vger.kernel.org, AJvYcCX/eEw8BMRYQPLjcg77VyBnrfMjup9s04C2waztBJ9tm3n6NCYcKIHs7jvNeycScfvYY91Ca47HFJogrbtH@vger.kernel.org
X-Gm-Message-State: AOJu0YxFqa0CHohq6C3yCB0gOsfbyBVqOX8P/UmhhClU9+/q7v64Vp52
	ixwm1DjgMIgDCywsAoBpqS71k01pkxWPE3WbgCTLlpigAygu2j7HlL4hc/04KIPeBLP4bw==
X-Gm-Gg: ASbGncvaMYb/mov6xpXzYJqFm/hPY/1FoG0q2ek8eIzdfF+tq4k6W9wGZWLpSFyUq/f
	xndtuEFv9a4dcMjXCXIIU0SgDzfwn4BkfLN2ohAgASo0Khc7w9KPvwCHZwps243GNHfJsXot7i7
	6gIYimDv/yGnbNazSbfI0bcazWymoIF9osOdBPewLBzlMWZWHqqoDEdIFYjoi4IkxGJJ0rN6Dzj
	dly2kAc+c1dRe9cVyhzfxfiDJf5pb5i3aQDRDBJjPwVIIa0fiQAdyaoC80OYWayMjrde1ImSm1m
	Gn/lpy3Tlad81nJbp88ClMdI4kUfmWn1BFyVOuHU8GZ1qSpMYpxTLrzu6d/i1zz1SqPtEAnj
X-Google-Smtp-Source: AGHT+IEMlcmwoxdTvWn0G98Yet4VJ5pqbwUzfEyzyHyYpjEiKg/CzXJUy3i9Oim6mG2bP7tJSFDg0w==
X-Received: by 2002:a05:6a21:a8c:b0:1f5:769a:a4bf with SMTP id adf61e73a8af0-21ee264c083mr6045628637.36.1749217195492;
        Fri, 06 Jun 2025 06:39:55 -0700 (PDT)
Received: from smtpclient.apple ([202.8.105.124])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2f5f66a7c9sm1161513a12.46.2025.06.06.06.39.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jun 2025 06:39:55 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v0] cgroup: Add lock guard support
From: Jemmy Wong <jemmywong512@gmail.com>
In-Reply-To: <20250606104248.GA1118@cmpxchg.org>
Date: Fri, 6 Jun 2025 21:39:39 +0800
Cc: Jemmy <jemmywong512@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Tejun Heo <tj@kernel.org>,
 =?utf-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>,
 "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CB194CAD-0279-4A4B-90EA-A510F1A3438E@gmail.com>
References: <20250605211053.19200-1-jemmywong512@gmail.com>
 <CAADnVQJyATTb9GFyBhOy5V_keAO5NZ6+zucLRyN27Cmg2FGPVA@mail.gmail.com>
 <20250606104248.GA1118@cmpxchg.org>
To: Johannes Weiner <hannes@cmpxchg.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Hi Johannes,

Thanks for your feedback. I understand your concerns about the=20
indentation and visual clarity with the lock guard.=20
Let me explain why I think it=E2=80=99s still a good choice:

1. Less Error-Prone
Lock guards automatically release the lock when the scope ends,=20
even with early returns or errors. Manual lock/unlock can miss an =
unlock,=20
causing deadlocks=E2=80=94lock guards prevent this.

2. Clear Critical Sections
The scoped_guard clearly shows where the critical section starts and =
ends,=20
making the code easier to follow and maintain, even if it adds =
indentation.

3. Fixing the Concerns
I agree the extra indentation can look messy. I can refactor to reduce =
nesting=20
or adjust the style to make critical sections clearer.=20
I=E2=80=99ll also ensure the lock guard only covers the critical =
section,=20
avoiding non-critical work inside.

Many modern programming languages provide lock guard-like constructs
to manage synchronization safely,=20
showing that this approach is a widely accepted best practice.=20
Manual lock/unlock is often discouraged because it=E2=80=99s =
error-prone,=20
especially in complex codebases. Here are a few examples:

C++:
std::mutex m;
void example() {
    std::lock_guard<std::mutex> lock(m); // Locks m
    // Critical section
} // Automatically unlocks m when scope ends


Rust:
use std::sync::Mutex;
let m =3D Mutex::new(0);
{
    let mut guard =3D m.lock().unwrap(); // Locks mutex
    *guard +=3D 1; // Critical section
} // Automatically unlocks here

Java:
ReentrantLock lock =3D new ReentrantLock();
try (lock.lock();) { // Locks and ensures unlock
    // Critical section
} // Automatically unlocks here

Python:
from threading import Lock
lock =3D Lock()
with lock: # Locks here
    # Critical section
# Automatically unlocks here

I think lock guards make the code safer and clearer,=20
but I=E2=80=99m happy to tweak the implementation to address your =
concerns.=20
Let me know your thoughts!

Best,
Jemmy


> On Jun 6, 2025, at 6:42=E2=80=AFPM, Johannes Weiner =
<hannes@cmpxchg.org> wrote:
>=20
> On Thu, Jun 05, 2025 at 05:54:15PM -0700, Alexei Starovoitov wrote:
>> On Thu, Jun 5, 2025 at 2:11=E2=80=AFPM Jemmy Wong =
<jemmywong512@gmail.com> wrote:
>>>=20
>>> This change replaces manual lock acquisition and release with lock =
guards
>>> to improve code robustness and reduce the risk of lock =
mismanagement.
>>> No functional changes to the cgroup logic are introduced.
>>>=20
>>> Signed-off-by: Jemmy Wong <jemmywong512@gmail.com>
>>>=20
>>> ---
>>> include/linux/cgroup.h     |   7 +
>>> kernel/bpf/cgroup.c        |  96 +++---
>>> kernel/bpf/local_storage.c |  12 +-
>>=20
>> Nack for bpf bits.
>> It only uglifies the code.
>=20
> I agree with this.
>=20
> The extra indentation from scoped guard is unfortunate.
>=20
> The guard with implicit unlock gives me the heebeejeebees - it's
> asymmetric and critical sections don't stand out visually at all.

There=E2=80=99re two types of guard: guard and socped_guard.=20

The guard is asymptomatic and doesn=E2=80=99t stand out visually very =
well.
We could choose socped_guard which clearly defines the boundaries of =
critical section.

To clarify usage:
- For critical sections is part of a function, prefer socped_guard,=20
    as it explicitly delineates the boundaries of the critical section.
- For critical sections spanning an entire function, prefer guard,=20
    as it better suits the broader scope.

> Adjusting critical section boundaries with guard means either:
> * indentation churn to convert to scoped guard,
> * forcing abstraction splits along critical sections (non-API
>  _locked functions), which makes the code flow harder to follow,
> * or straight-up violating abstraction layering and adding
>  non-critical stuff to callers where it doesn't make sense.
>=20
> I don't remember the last production bug from forgetting to drop a
> lock. Meanwhile, the things that people actually seem to struggle with
> when it comes to locks appear to become harder with those primitives.

