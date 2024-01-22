Return-Path: <cgroups+bounces-1211-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA50F83758A
	for <lists+cgroups@lfdr.de>; Mon, 22 Jan 2024 22:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59FBEB21985
	for <lists+cgroups@lfdr.de>; Mon, 22 Jan 2024 21:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC33481C8;
	Mon, 22 Jan 2024 21:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lvQ7qsLf"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5415B481B9
	for <cgroups@vger.kernel.org>; Mon, 22 Jan 2024 21:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705959599; cv=none; b=l+f4+VPGvI6+n4M0dJTwraPCzV8T2dDmz5j8w4DpFszRWHwk6rs4QPsUqzTrU/4xZgqQUjNnLFE+Avw+vW2u9fAQimnfBzO4FbShOJ59SswLtItOYAV1gKaBGPSO+uqR+WIHIJ93ofM9YUro7jnbPl30Giip+8d2ZWcMChH+WXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705959599; c=relaxed/simple;
	bh=0Yo7/+bEKqpWf6UK9EnJCv29oqgf3hWqvTgmDOjmObE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L72rvXzoD4fLWVJR0Pmorgs6HXkTyJOjNHbX3AaOlCq/cu0f4tzgAkrhmjYr3I3Ifx+09BfRteiOAFdptiOrMYw4Xo8mvEiyzp6dLLHtF/YV15onALuH2UBZcvXG/9TUgWAW3w4dqVUOLaF4ijuqx0yMuWO57zgIXVJ4oCjWMyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lvQ7qsLf; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55a349cf29cso4188835a12.0
        for <cgroups@vger.kernel.org>; Mon, 22 Jan 2024 13:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705959595; x=1706564395; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OJl69jgvDfPjiM2uB3CG3ZOcpFE/TqmJUUOEN3Q1aTs=;
        b=lvQ7qsLfJBvTQY61R1kNGMkswh8BeEcbSa+hJQoeRYjrCfA/YVKcP30wQwWl1DC0UQ
         Y3sU3qCYX9A50wz+ehC3ApPJfJc4gAQ02ixUvcD3ax9H8KMd5CyhjL/I38B4z5TbeCdN
         z3Ah1kvdEWJj7P5mvzGsoNzOMTN+vDZVhgX8sO9pSXJ5Vz3Em5uZKTsrTEMNpsjwKY8E
         W1Vkc+5X3JbV0zviHfzPNgHh1IfIJvzZZloL7j4ICoeqTbM9Fc3don10hL8X8BmO5F0Y
         FsFxzuSu18nXublaA3cCL1phziiaiWRnaq2KF9XOQjyIKLWfbQI0VIIJxsIPOFNqmoL3
         crkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705959595; x=1706564395;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OJl69jgvDfPjiM2uB3CG3ZOcpFE/TqmJUUOEN3Q1aTs=;
        b=d519nLNNrYC37A7A/tcS6rq+jkIdOhapIU4kCy2qY8+JdP8Xl0G3xrC/oQqw7FOaQo
         iYx/zegclAaBk8vrfGoxdQ/agl7cCK+iF5Ge9Bmb6brktmbxyYvR3sI20Z5hzk4lXht7
         SaOCdXJaC68bEPEUnCo68ek/ZKwJd0QxYRNEsaYrEFJlV+MxAgjHMlWP3RtR7+P8/nd/
         Vvel/WiMO18J7PTNtkz0KubHFdofFlQ0bn/30QcObdZEdi37WshmL4+mfYex1Tryefsp
         LS8565osLCQDK7aLM481QSZDU8YJGHxk+bisy2Svmi9X5qkKygKl4W4wlzdkAzoUCPWx
         8fNA==
X-Gm-Message-State: AOJu0Yzn3Aemzlfu841Sfluy/tmN6ORIT/yCiU+B7kpt85VvVTb261Y+
	l+D45NoVEB1gndcSAn6ycmwGRQq8eIkrR5yxOq8oYFk4LzyxblOcIF1vBJT57EaSzpq/oZ9AVKK
	rjAS04xet4ryYGc3bwMV87/yi562pmgDPfLyJ
X-Google-Smtp-Source: AGHT+IFNt0YCom8kIcDqsIQbiBf39l15C3VxyveKkoMqocLWukEgOsuQSRo135FaSfm9uwdrkIiU5v4TEQUqKhERWXg=
X-Received: by 2002:a17:906:5a47:b0:a2e:d3fe:9bb7 with SMTP id
 my7-20020a1709065a4700b00a2ed3fe9bb7mr2129319ejc.124.1705959595177; Mon, 22
 Jan 2024 13:39:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401221624.cb53a8ca-oliver.sang@intel.com>
In-Reply-To: <202401221624.cb53a8ca-oliver.sang@intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 22 Jan 2024 13:39:19 -0800
Message-ID: <CAJD7tka0o+jn3UkXB+ZfZvRw1v+KysJbaGQvJdHcSmAhYC5TQA@mail.gmail.com>
Subject: Re: [linus:master] [mm] 8d59d2214c: vm-scalability.throughput -36.6% regression
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, Shakeel Butt <shakeelb@google.com>, 
	Chris Li <chrisl@kernel.org>, Greg Thelen <gthelen@google.com>, 
	Ivan Babrou <ivan@cloudflare.com>, Michal Hocko <mhocko@kernel.org>, 
	Michal Koutny <mkoutny@suse.com>, Muchun Song <muchun.song@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Waiman Long <longman@redhat.com>, Wei Xu <weixugc@google.com>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, ying.huang@intel.com, feng.tang@intel.com, 
	fengwei.yin@intel.com
Content-Type: multipart/mixed; boundary="000000000000acf02c060f8fab3d"

--000000000000acf02c060f8fab3d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 12:39=E2=80=AFAM kernel test robot
<oliver.sang@intel.com> wrote:
>
>
>
> hi, Yosry Ahmed,
>
> per your suggestion in
> https://lore.kernel.org/all/CAJD7tkameJBrJQxRj+ibKL6-yd-i0wyoyv2cgZdh3Zep=
A1p7wA@mail.gmail.com/
> "I think it would be useful to know if there are
> regressions/improvements in other microbenchmarks, at least to
> investigate whether they represent real regressions."
>
> we still report below two regressions to you just FYI what we observed in=
 our
> microbenchmark tests.
> (we still captured will-it-scale::fallocate regression but ignore here pe=
r
> your commit message)
>
>
> Hello,
>
> kernel test robot noticed a -36.6% regression of vm-scalability.throughpu=
t on:
>
>
> commit: 8d59d2214c2362e7a9d185d80b613e632581af7b ("mm: memcg: make stats =
flushing threshold per-memcg")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> testcase: vm-scalability
> test machine: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @=
 2.90GHz (Cooper Lake) with 192G memory
> parameters:
>
>         runtime: 300s
>         size: 1T
>         test: lru-shm
>         cpufreq_governor: performance
>
> test-description: The motivation behind this suite is to exercise functio=
ns and regions of the mm/ of the Linux kernel which are of interest to us.
> test-url: https://git.kernel.org/cgit/linux/kernel/git/wfg/vm-scalability=
.git/
>
> In addition to that, the commit also has significant impact on the follow=
ing tests:
>
> +------------------+-----------------------------------------------------=
-----------------------------------------------+
> | testcase: change | will-it-scale: will-it-scale.per_process_ops -32.3% =
regression                                     |
> | test machine     | 104 threads 2 sockets (Skylake) with 192G memory    =
                                               |
> | test parameters  | cpufreq_governor=3Dperformance                      =
                                                 |
> |                  | mode=3Dprocess                                      =
                                                 |
> |                  | nr_task=3D50%                                       =
                                                 |
> |                  | test=3Dtlb_flush2                                   =
                                                 |
> +------------------+-----------------------------------------------------=
-----------------------------------------------+
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202401221624.cb53a8ca-oliver.san=
g@intel.com

Thanks for reporting this. We have had these patches running on O(10K)
machines in our production for a while now, and there haven't been any
complaints (at least not yet). OTOH, we do see significant CPU savings
on reading memcg stats.

That being said, I think we can improve the performance here by
caching pointers to the parent_memcg->vmstats_percpu and
memcg->vmstats in struct memcg_vmstat_percpu. This should
significantly reduce the memory fetches in the loop in
memcg_rstat_updated().

Oliver, would you be able to test if the attached patch helps? It's
based on 8d59d2214c236.

[..]

--000000000000acf02c060f8fab3d
Content-Type: application/octet-stream; 
	name="0001-mm-memcg-optimize-parent-iteration-in-memcg_rstat_up.patch"
Content-Disposition: attachment; 
	filename="0001-mm-memcg-optimize-parent-iteration-in-memcg_rstat_up.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lrpg9pbu0>
X-Attachment-Id: f_lrpg9pbu0

RnJvbSA4ZDA0YzM4MTM3YzcxZDE1NzdhODU3NmZiNzVkYjA3ZjNiZjkyNDkxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZb3NyeSBBaG1lZCA8eW9zcnlhaG1lZEBnb29nbGUuY29tPgpE
YXRlOiBNb24sIDIyIEphbiAyMDI0IDIxOjM1OjI5ICswMDAwClN1YmplY3Q6IFtQQVRDSF0gbW06
IG1lbWNnOiBvcHRpbWl6ZSBwYXJlbnQgaXRlcmF0aW9uIGluIG1lbWNnX3JzdGF0X3VwZGF0ZWQo
KQoKU2lnbmVkLW9mZi1ieTogWW9zcnkgQWhtZWQgPHlvc3J5YWhtZWRAZ29vZ2xlLmNvbT4KLS0t
CiBtbS9tZW1jb250cm9sLmMgfCA0NSArKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9tbS9tZW1jb250cm9sLmMgYi9tbS9tZW1jb250cm9sLmMKaW5k
ZXggYzVhYTBjMmNiNjhiMi4uYjVlYzRhODQxMzIxNSAxMDA2NDQKLS0tIGEvbW0vbWVtY29udHJv
bC5jCisrKyBiL21tL21lbWNvbnRyb2wuYwpAQCAtNjM0LDYgKzYzNCwxMCBAQCBzdHJ1Y3QgbWVt
Y2dfdm1zdGF0c19wZXJjcHUgewogCiAJLyogU3RhdHMgdXBkYXRlcyBzaW5jZSB0aGUgbGFzdCBm
bHVzaCAqLwogCXVuc2lnbmVkIGludAkJc3RhdHNfdXBkYXRlczsKKworCS8qIENhY2hlZCBwb2lu
dGVycyBmb3IgZmFzdCB1cGRhdGVzIGluIG1lbWNnX3JzdGF0X3VwZGF0ZWQoKSAqLworCXN0cnVj
dCBtZW1jZ192bXN0YXRzX3BlcmNwdQkqcGFyZW50OworCXN0cnVjdCBtZW1jZ192bXN0YXRzCQkq
dm1zdGF0czsKIH07CiAKIHN0cnVjdCBtZW1jZ192bXN0YXRzIHsKQEAgLTY5OCwzNiArNzAyLDM0
IEBAIHN0YXRpYyB2b2lkIG1lbWNnX3N0YXRzX3VubG9jayh2b2lkKQogfQogCiAKLXN0YXRpYyBi
b29sIG1lbWNnX3Nob3VsZF9mbHVzaF9zdGF0cyhzdHJ1Y3QgbWVtX2Nncm91cCAqbWVtY2cpCitz
dGF0aWMgYm9vbCBtZW1jZ192bXN0YXRzX25lZWRzX2ZsdXNoKHN0cnVjdCBtZW1jZ192bXN0YXRz
ICp2bXN0YXRzKQogewotCXJldHVybiBhdG9taWM2NF9yZWFkKCZtZW1jZy0+dm1zdGF0cy0+c3Rh
dHNfdXBkYXRlcykgPgorCXJldHVybiBhdG9taWM2NF9yZWFkKCZ2bXN0YXRzLT5zdGF0c191cGRh
dGVzKSA+CiAJCU1FTUNHX0NIQVJHRV9CQVRDSCAqIG51bV9vbmxpbmVfY3B1cygpOwogfQogCiBz
dGF0aWMgaW5saW5lIHZvaWQgbWVtY2dfcnN0YXRfdXBkYXRlZChzdHJ1Y3QgbWVtX2Nncm91cCAq
bWVtY2csIGludCB2YWwpCiB7CisJc3RydWN0IG1lbWNnX3Ztc3RhdHNfcGVyY3B1ICpzdGF0YzsK
IAlpbnQgY3B1ID0gc21wX3Byb2Nlc3Nvcl9pZCgpOwotCXVuc2lnbmVkIGludCB4OwogCiAJaWYg
KCF2YWwpCiAJCXJldHVybjsKIAogCWNncm91cF9yc3RhdF91cGRhdGVkKG1lbWNnLT5jc3MuY2dy
b3VwLCBjcHUpOwotCi0JZm9yICg7IG1lbWNnOyBtZW1jZyA9IHBhcmVudF9tZW1fY2dyb3VwKG1l
bWNnKSkgewotCQl4ID0gX190aGlzX2NwdV9hZGRfcmV0dXJuKG1lbWNnLT52bXN0YXRzX3BlcmNw
dS0+c3RhdHNfdXBkYXRlcywKLQkJCQkJICBhYnModmFsKSk7Ci0KLQkJaWYgKHggPCBNRU1DR19D
SEFSR0VfQkFUQ0gpCisJc3RhdGMgPSB0aGlzX2NwdV9wdHIobWVtY2ctPnZtc3RhdHNfcGVyY3B1
KTsKKwlmb3IgKDsgc3RhdGM7IHN0YXRjID0gc3RhdGMtPnBhcmVudCkgeworCQlzdGF0Yy0+c3Rh
dHNfdXBkYXRlcyArPSBhYnModmFsKTsKKwkJaWYgKHN0YXRjLT5zdGF0c191cGRhdGVzIDwgTUVN
Q0dfQ0hBUkdFX0JBVENIKQogCQkJY29udGludWU7CiAKIAkJLyoKIAkJICogSWYgQG1lbWNnIGlz
IGFscmVhZHkgZmx1c2gtYWJsZSwgaW5jcmVhc2luZyBzdGF0c191cGRhdGVzIGlzCiAJCSAqIHJl
ZHVuZGFudC4gQXZvaWQgdGhlIG92ZXJoZWFkIG9mIHRoZSBhdG9taWMgdXBkYXRlLgogCQkgKi8K
LQkJaWYgKCFtZW1jZ19zaG91bGRfZmx1c2hfc3RhdHMobWVtY2cpKQotCQkJYXRvbWljNjRfYWRk
KHgsICZtZW1jZy0+dm1zdGF0cy0+c3RhdHNfdXBkYXRlcyk7Ci0JCV9fdGhpc19jcHVfd3JpdGUo
bWVtY2ctPnZtc3RhdHNfcGVyY3B1LT5zdGF0c191cGRhdGVzLCAwKTsKKwkJaWYgKCFtZW1jZ192
bXN0YXRzX25lZWRzX2ZsdXNoKHN0YXRjLT52bXN0YXRzKSkKKwkJCWF0b21pYzY0X2FkZCh4LCAm
c3RhdGMtPnZtc3RhdHMtPnN0YXRzX3VwZGF0ZXMpOworCQlzdGF0Yy0+c3RhdHNfdXBkYXRlcyA9
IDA7CiAJfQogfQogCkBAIC03NTEsNyArNzUzLDcgQEAgc3RhdGljIHZvaWQgZG9fZmx1c2hfc3Rh
dHModm9pZCkKIAogdm9pZCBtZW1fY2dyb3VwX2ZsdXNoX3N0YXRzKHZvaWQpCiB7Ci0JaWYgKG1l
bWNnX3Nob3VsZF9mbHVzaF9zdGF0cyhyb290X21lbV9jZ3JvdXApKQorCWlmIChtZW1jZ192bXN0
YXRzX25lZWRzX2ZsdXNoKHJvb3RfbWVtX2Nncm91cC0+dm1zdGF0cykpCiAJCWRvX2ZsdXNoX3N0
YXRzKCk7CiB9CiAKQEAgLTc2NSw3ICs3NjcsNyBAQCB2b2lkIG1lbV9jZ3JvdXBfZmx1c2hfc3Rh
dHNfcmF0ZWxpbWl0ZWQodm9pZCkKIHN0YXRpYyB2b2lkIGZsdXNoX21lbWNnX3N0YXRzX2R3b3Jr
KHN0cnVjdCB3b3JrX3N0cnVjdCAqdykKIHsKIAkvKgotCSAqIERlbGliZXJhdGVseSBpZ25vcmUg
bWVtY2dfc2hvdWxkX2ZsdXNoX3N0YXRzKCkgaGVyZSBzbyB0aGF0IGZsdXNoaW5nCisJICogRGVs
aWJlcmF0ZWx5IGlnbm9yZSBtZW1jZ192bXN0YXRzX25lZWRzX2ZsdXNoKCkgaGVyZSBzbyB0aGF0
IGZsdXNoaW5nCiAJICogaW4gbGF0ZW5jeS1zZW5zaXRpdmUgcGF0aHMgaXMgYXMgY2hlYXAgYXMg
cG9zc2libGUuCiAJICovCiAJZG9fZmx1c2hfc3RhdHMoKTsKQEAgLTU0NTMsMTAgKzU0NTUsMTEg
QEAgc3RhdGljIHZvaWQgbWVtX2Nncm91cF9mcmVlKHN0cnVjdCBtZW1fY2dyb3VwICptZW1jZykK
IAlfX21lbV9jZ3JvdXBfZnJlZShtZW1jZyk7CiB9CiAKLXN0YXRpYyBzdHJ1Y3QgbWVtX2Nncm91
cCAqbWVtX2Nncm91cF9hbGxvYyh2b2lkKQorc3RhdGljIHN0cnVjdCBtZW1fY2dyb3VwICptZW1f
Y2dyb3VwX2FsbG9jKHN0cnVjdCBtZW1fY2dyb3VwICpwYXJlbnQpCiB7CisJc3RydWN0IG1lbWNn
X3Ztc3RhdHNfcGVyY3B1ICpzdGF0YywgKnBzdGF0YzsKIAlzdHJ1Y3QgbWVtX2Nncm91cCAqbWVt
Y2c7Ci0JaW50IG5vZGU7CisJaW50IG5vZGUsIGNwdTsKIAlpbnQgX19tYXliZV91bnVzZWQgaTsK
IAlsb25nIGVycm9yID0gLUVOT01FTTsKIApAQCAtNTQ4MCw2ICs1NDgzLDE0IEBAIHN0YXRpYyBz
dHJ1Y3QgbWVtX2Nncm91cCAqbWVtX2Nncm91cF9hbGxvYyh2b2lkKQogCWlmICghbWVtY2ctPnZt
c3RhdHNfcGVyY3B1KQogCQlnb3RvIGZhaWw7CiAKKwlmb3JfZWFjaF9wb3NzaWJsZV9jcHUoY3B1
KSB7CisJCWlmIChwYXJlbnQpCisJCQlwc3RhdGMgPSBwZXJfY3B1X3B0cihwYXJlbnQtPnZtc3Rh
dHNfcGVyY3B1LCBjcHUpOworCQlzdGF0YyA9IHBlcl9jcHVfcHRyKG1lbWNnLT52bXN0YXRzX3Bl
cmNwdSwgY3B1KTsKKwkJc3RhdGMtPnBhcmVudCA9IHBhcmVudCA/IHBzdGF0YyA6IE5VTEw7CisJ
CXN0YXRjLT52bXN0YXRzID0gbWVtY2ctPnZtc3RhdHM7CisJfQorCiAJZm9yX2VhY2hfbm9kZShu
b2RlKQogCQlpZiAoYWxsb2NfbWVtX2Nncm91cF9wZXJfbm9kZV9pbmZvKG1lbWNnLCBub2RlKSkK
IAkJCWdvdG8gZmFpbDsKQEAgLTU1MjUsNyArNTUzNiw3IEBAIG1lbV9jZ3JvdXBfY3NzX2FsbG9j
KHN0cnVjdCBjZ3JvdXBfc3Vic3lzX3N0YXRlICpwYXJlbnRfY3NzKQogCXN0cnVjdCBtZW1fY2dy
b3VwICptZW1jZywgKm9sZF9tZW1jZzsKIAogCW9sZF9tZW1jZyA9IHNldF9hY3RpdmVfbWVtY2co
cGFyZW50KTsKLQltZW1jZyA9IG1lbV9jZ3JvdXBfYWxsb2MoKTsKKwltZW1jZyA9IG1lbV9jZ3Jv
dXBfYWxsb2MocGFyZW50KTsKIAlzZXRfYWN0aXZlX21lbWNnKG9sZF9tZW1jZyk7CiAJaWYgKElT
X0VSUihtZW1jZykpCiAJCXJldHVybiBFUlJfQ0FTVChtZW1jZyk7Ci0tIAoyLjQzLjAuNDI5Lmc0
MzJlYWEyYzZiLWdvb2cKCg==
--000000000000acf02c060f8fab3d--

