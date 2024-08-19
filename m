Return-Path: <cgroups+bounces-4355-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D362E95744B
	for <lists+cgroups@lfdr.de>; Mon, 19 Aug 2024 21:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 546E21F247C2
	for <lists+cgroups@lfdr.de>; Mon, 19 Aug 2024 19:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CA361FD7;
	Mon, 19 Aug 2024 19:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XDvgHIN1"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC811DC463
	for <cgroups@vger.kernel.org>; Mon, 19 Aug 2024 19:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724095188; cv=none; b=HcaLM1mqdm2HxwsptKzSbQMAg+iodq6z6/5NK9y4TK3vagwPTjrsfkM39iir5T/4w+aNQvcSiU503Bjso3TuRWmha46cEYnGiI149iBQjmWADIBrQZVYA0O3wCAJc4ftF4v4krG0d9O4+Bz8leXtUyzSDBnQmaok+2cdlVAJZyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724095188; c=relaxed/simple;
	bh=8vjIWzmx4KTL7ajgUxXEjxrazirQfyoLTM19Fh0tBnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m667CrVZysxRGvWIuBazdWMLWcVKKA4vJsdPiZuH/g6zuKmdTBfSrOBc8wBc0wShHMI+5Pj25VylYrwprfpbbrh1DmlkVFWPr99uDgPMZhHuooWkyWmeT4zyCrkXp3udtIByhIUQz3YDTveiX585k5MpDTma+clLewMZrn+XiKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XDvgHIN1; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso7177282a12.1
        for <cgroups@vger.kernel.org>; Mon, 19 Aug 2024 12:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724095185; x=1724699985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZM5zMJ0sB4lMiTqOGEZX6UeVloMpJCvx8UgNki8n98=;
        b=XDvgHIN1+tfhrjAP7kEWe5ivV4XmNfY0Wtv7BwFt378EdLa1WezBbkbbqZ21Zwnb+I
         041CT77HW0gL5X6k5NR3xmWbbtAbCagCe7gBkyokbUrJHi9x0ls7y5b+dHZ1kuaI9+2F
         ooo6WGU/bc6Ogge0ipfC2Khgmj6knJqQxHRhIb+OUK8grDk0Hefrp9K1SqqhCItzPavQ
         x58nhpjnaa+2KfEvhycql3UtWZGgKYgxg+KaOMRoWMML+aRzrfRh0HsMLmmrib++J/0F
         TcMMEdRFg6/GGxEjMk8l38r4QbTVONz2bMAbFBilcO5MXXbXqk06jSYt218ShcY9Oa5U
         RVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724095185; x=1724699985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZM5zMJ0sB4lMiTqOGEZX6UeVloMpJCvx8UgNki8n98=;
        b=wIghjHod0M+jzVmKo2zwoqgylSO2OgpdRMjL09ef2tImzueS4XcIljCocmckRI1AiT
         U/CUz/j6GRSiHAZItcI+ES0726MUe83DKxlCG0ticBoTaF1XL9VaICn/VI1vRA8phXdA
         xl28nbOSJ/fAypzstgOff13JNp/iZIsvjJQ0jt5jn2+0q2QjrlyF2eU27JzEkRx6XEHa
         ywKCxzosyevATAhbNAuQH3jHiIp5FsIOp1vYqZOi8rywBjlUXAAUOJsSw/x2/Gxw2uYo
         gQjieqauoBybvBQZBGwJ6a7r2TWDQRTO73M4jOotiPxB1xNUkblT1GIJCV14qv2rIG2M
         Yk6w==
X-Forwarded-Encrypted: i=1; AJvYcCXTbPQamSpR1O39kdgQN/ydXayDtUJ5uq6AkSaihhYhlD0N8u3hE6dbU58WsU1U4m2NCsBYepZBCdpdQgu3Y1xL+hohIvz/WQ==
X-Gm-Message-State: AOJu0YwNzVXVuXNGR0760deTc0u68OQ6QeaVDVE5eGDSO3k8fxo1lTjN
	Zu4jOhDw1sjFWmzp3aSc044o8TCK6s9cxIWgdykARJNM33SxL4Pv5jpyIB4oKrnWhbZrB4rLOrT
	NoOfkaanSEORxstgXlZAXx4++xq73XNwKnHvi
X-Google-Smtp-Source: AGHT+IHMItryRi8P70QAVbdIuSGoqw5A/WfIe0nTbfG9cMvEsczl2pfv6OH6aJAnOsvEnmXPd7UYyKKeG2aHjAG0ZG4=
X-Received: by 2002:a17:906:d7c4:b0:a79:7f94:8a73 with SMTP id
 a640c23a62f3a-a839292df2emr843653666b.20.1724095184459; Mon, 19 Aug 2024
 12:19:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816144344.18135-1-me@yhndnzj.com> <20240816144344.18135-2-me@yhndnzj.com>
In-Reply-To: <20240816144344.18135-2-me@yhndnzj.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 19 Aug 2024 12:19:08 -0700
Message-ID: <CAJD7tkYRiA7113ehpXoiafJtk8Z+j6nV_bQWK0xoX3KaK6=wcQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selftests: test_zswap: add test for hierarchical zswap.writeback
To: Mike Yuan <me@yhndnzj.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 7:44=E2=80=AFAM Mike Yuan <me@yhndnzj.com> wrote:
>
> Ensure that zswap.writeback check goes up the cgroup tree.

Too concise :) Perhaps a little bit of description of what you are
doing would be helpful.

>
> Signed-off-by: Mike Yuan <me@yhndnzj.com>
> ---
>  tools/testing/selftests/cgroup/test_zswap.c | 69 ++++++++++++++-------
>  1 file changed, 48 insertions(+), 21 deletions(-)
>
> diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/=
selftests/cgroup/test_zswap.c
> index 190096017f80..7da6f9dc1066 100644
> --- a/tools/testing/selftests/cgroup/test_zswap.c
> +++ b/tools/testing/selftests/cgroup/test_zswap.c
> @@ -263,15 +263,13 @@ static int test_zswapin(const char *root)
>  static int attempt_writeback(const char *cgroup, void *arg)
>  {
>         long pagesize =3D sysconf(_SC_PAGESIZE);
> -       char *test_group =3D arg;
>         size_t memsize =3D MB(4);
>         char buf[pagesize];
>         long zswap_usage;
> -       bool wb_enabled;
> +       bool wb_enabled =3D *(bool *) arg;
>         int ret =3D -1;
>         char *mem;
>
> -       wb_enabled =3D cg_read_long(test_group, "memory.zswap.writeback")=
;
>         mem =3D (char *)malloc(memsize);
>         if (!mem)
>                 return ret;
> @@ -288,12 +286,12 @@ static int attempt_writeback(const char *cgroup, vo=
id *arg)
>                 memcpy(&mem[i], buf, pagesize);
>
>         /* Try and reclaim allocated memory */
> -       if (cg_write_numeric(test_group, "memory.reclaim", memsize)) {
> +       if (cg_write_numeric(cgroup, "memory.reclaim", memsize)) {
>                 ksft_print_msg("Failed to reclaim all of the requested me=
mory\n");
>                 goto out;
>         }
>
> -       zswap_usage =3D cg_read_long(test_group, "memory.zswap.current");
> +       zswap_usage =3D cg_read_long(cgroup, "memory.zswap.current");
>
>         /* zswpin */
>         for (int i =3D 0; i < memsize; i +=3D pagesize) {
> @@ -303,7 +301,7 @@ static int attempt_writeback(const char *cgroup, void=
 *arg)
>                 }
>         }
>
> -       if (cg_write_numeric(test_group, "memory.zswap.max", zswap_usage/=
2))
> +       if (cg_write_numeric(cgroup, "memory.zswap.max", zswap_usage/2))
>                 goto out;
>
>         /*
> @@ -312,7 +310,7 @@ static int attempt_writeback(const char *cgroup, void=
 *arg)
>          * If writeback is disabled, memory reclaim will fail as zswap is=
 limited and
>          * it can't writeback to swap.
>          */
> -       ret =3D cg_write_numeric(test_group, "memory.reclaim", memsize);
> +       ret =3D cg_write_numeric(cgroup, "memory.reclaim", memsize);
>         if (!wb_enabled)
>                 ret =3D (ret =3D=3D -EAGAIN) ? 0 : -1;
>
> @@ -321,12 +319,38 @@ static int attempt_writeback(const char *cgroup, vo=
id *arg)
>         return ret;
>  }
>
> +static int test_zswap_writeback_one(const char *cgroup, bool wb)
> +{
> +       long zswpwb_before, zswpwb_after;
> +
> +       zswpwb_before =3D get_cg_wb_count(cgroup);
> +       if (zswpwb_before !=3D 0) {
> +               ksft_print_msg("zswpwb_before =3D %ld instead of 0\n", zs=
wpwb_before);
> +               return -1;
> +       }
> +
> +       if (cg_run(cgroup, attempt_writeback, (void *) &wb))
> +               return -1;
> +
> +       /* Verify that zswap writeback occurred only if writeback was ena=
bled */
> +       zswpwb_after =3D get_cg_wb_count(cgroup);
> +       if (zswpwb_after < 0)
> +               return -1;
> +
> +       if (wb !=3D !!zswpwb_after) {
> +               ksft_print_msg("zswpwb_after is %ld while wb is %s",
> +                               zswpwb_after, wb ? "enabled" : "disabled"=
);
> +               return -1;
> +       }
> +
> +       return 0;
> +}
> +
>  /* Test to verify the zswap writeback path */
>  static int test_zswap_writeback(const char *root, bool wb)
>  {
> -       long zswpwb_before, zswpwb_after;
>         int ret =3D KSFT_FAIL;
> -       char *test_group;
> +       char *test_group, *test_group_child =3D NULL;
>
>         test_group =3D cg_name(root, "zswap_writeback_test");
>         if (!test_group)
> @@ -336,29 +360,32 @@ static int test_zswap_writeback(const char *root, b=
ool wb)
>         if (cg_write(test_group, "memory.zswap.writeback", wb ? "1" : "0"=
))
>                 goto out;
>
> -       zswpwb_before =3D get_cg_wb_count(test_group);
> -       if (zswpwb_before !=3D 0) {
> -               ksft_print_msg("zswpwb_before =3D %ld instead of 0\n", zs=
wpwb_before);
> +       if (test_zswap_writeback_one(test_group, wb))
>                 goto out;
> -       }
>
> -       if (cg_run(test_group, attempt_writeback, (void *) test_group))
> +       if (cg_write(test_group, "memory.zswap.max", "max"))
> +               goto out;

Why is this needed? Isn't this the default value?

> +       if (cg_write(test_group, "cgroup.subtree_control", "+memory"))
>                 goto out;
>
> -       /* Verify that zswap writeback occurred only if writeback was ena=
bled */
> -       zswpwb_after =3D get_cg_wb_count(test_group);
> -       if (zswpwb_after < 0)
> +       test_group_child =3D cg_name(test_group, "zswap_writeback_test_ch=
ild");
> +       if (!test_group_child)
> +               goto out;
> +       if (cg_create(test_group_child))
> +               goto out;

I'd rather have all the hierarchy setup at the beginning of the test,
before the actual test logic. I don't feel strongly about it though.

> +       if (cg_write(test_group_child, "memory.zswap.writeback", "1"))
>                 goto out;

Is the idea here that we always hardcode the child's zswap.writeback
to 1, and the parent's zswap.writeback changes from 0 to 1, and we
check that the parent's value is what matters?
I think we need a comment here.

TBH, I expected a separate test that checks different combinations of
parent and child values (e.g. also verifies that if the parent is
enabled but child is disabled, writeback is disabled).

>
> -       if (wb !=3D !!zswpwb_after) {
> -               ksft_print_msg("zswpwb_after is %ld while wb is %s",
> -                               zswpwb_after, wb ? "enabled" : "disabled"=
);
> +       if (test_zswap_writeback_one(test_group_child, wb))
>                 goto out;
> -       }
>
>         ret =3D KSFT_PASS;
>
>  out:
> +       if (test_group_child) {
> +               cg_destroy(test_group_child);
> +               free(test_group_child);
> +       }
>         cg_destroy(test_group);
>         free(test_group);
>         return ret;
> --
> 2.46.0
>
>

