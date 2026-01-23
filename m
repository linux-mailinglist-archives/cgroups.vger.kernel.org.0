Return-Path: <cgroups+bounces-13402-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YC9RELl2c2kEwAAAu9opvQ
	(envelope-from <cgroups+bounces-13402-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 14:25:13 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 982F876358
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 14:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A589230427E4
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 13:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB4F2BE7D2;
	Fri, 23 Jan 2026 13:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bF6fi6VY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A216221D5B0
	for <cgroups@vger.kernel.org>; Fri, 23 Jan 2026 13:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769174681; cv=pass; b=Ij1Fhr2exW1qFdbm7xFlkCVcI80mGrBoe8ZQgGvY3ctlASw8Zslkf73x7gVpDkJnHtIB0eFDd8aWdwUirFAdStl6PYsZLNXa3Ea0c78THbeHqWYW4iGSA2OQFV+o8qemO/wDGv9IRM4gg9rCIHqnF9zz/cN0E9WzWx3RR0QzjYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769174681; c=relaxed/simple;
	bh=S85iHslS4YwWYTQjAd0SC9tu+gwUWLqCzg8HyOqxokc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cIV0ngpLPPMNWr4qKJcbNqp0MgtDSTbwJ99WG4OiVNuB7GKxBiFd9zlcoIeBqfN4yzYIBI4nkD0sif2qqjXGUphakTsbl5grvtpoo9/13KbvtDy31I4BgtJio9VNvZ2624zGaiIPicu0+7B9OTDxhNWtg2mlIydu+PKy8bYOFbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bF6fi6VY; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59b8466b4a8so1913034e87.1
        for <cgroups@vger.kernel.org>; Fri, 23 Jan 2026 05:24:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769174678; cv=none;
        d=google.com; s=arc-20240605;
        b=ld/Egq37XdTlqh/WtXv0GKvAMp7ZNJH8wIJnzPPvn3z7C5upPMtz2o9ykt/xRGlUTo
         DDc9zxSkAVSncoEhQ79/cH0USRREf0VV+QIIqMfwfL2FCD/8eEt1NT626EvrUWXh41UO
         9Vjy/6N4+hVgN5JpyAgzt8HOVe0/1mEYrXDGSw2CLeRyav5GwkG+82nx5KqxXIkPcRkb
         QriWrKaGm4ZOj+1MiW19/XztSXMdX/H5cjTukgFmjuUpQJcFdtZdCJnLA2ulqcYObVs0
         XzX8/MpLMNgov/Sq7Eq5g4vFC0Kod4nN9gWGDolYjc+luAQ5gLeHfhOj3SPeBvqj5diZ
         HPDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DuGHsLpdvrQaNLUamOe8zWzhYMbQRAN+arTRx+eFXHU=;
        fh=26+t+9tQKYDqnXtSNeYh03hFNMl4pglafX6uvTEp9+o=;
        b=cQZFSZtUUiP/Y4Z+8lk8FaVfxa0myoy0R0lJBazQQGbzNV4W9/lqXdrn2qKsGRUc0S
         OcVIobMpl2zuyARdpgMr3rwEyeDpiJTFYF2PwJEPupiMvbNQqnedtQbAuyroGjCOMix7
         ZuSvP+X3qYUkPfB7QJoWwQvjLBYUNgcK3UAZaSGiMYtBb0YU3mC9g8a3rCir4fZToNhu
         bkesvwmMDsqgyFfrcid+tkLH0nlSTk1LioRzJlo00gJwmXgQVhSosmjDJmb0cIRu6G5d
         SAREbevCamG3s3uvBv3jAwpXyc9NFGiEKPRxCNnRe22PI0vXhvgvBWwnETlPuriLJjLJ
         vpQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769174678; x=1769779478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DuGHsLpdvrQaNLUamOe8zWzhYMbQRAN+arTRx+eFXHU=;
        b=bF6fi6VYwWYn8Hq8/jI+NqARDCEhNNH3i1/6rSK4Gzcx8dvdOmU7NoasUbKqLY4zx/
         CG5jN2iMB36gdMtodhm1dVN8B2ZbCvWh/pZF24R85mc6+rKOPuv7BK0q2C2OugKzbpcm
         Y99TlaoyBUyK3qoNGHwHKJQ9TuL87C0zZVSogu8hE7pfXQPIP6qOi6rlKwqMT65xONSo
         r9cEedek3uAOf8S3H9x1zs+AinTrGEztJlZ4/hGhuJvK3xi+UsBrusGyxB025k08RoOt
         XCv5CfgDl0yxMnuJxt52aPpzdgPpYK/IeHwENnizYLu2Jw7eDi3pS+SwNRDgQmfzsn22
         1J5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769174678; x=1769779478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DuGHsLpdvrQaNLUamOe8zWzhYMbQRAN+arTRx+eFXHU=;
        b=MrHFMx7j9V8oK9Tmj9v+0LKsqmHBfVR0mdrF13EOIr5UD6i+LMbdATVO++vmNsogjg
         riVhiEISnjDvMQiO9VUnImJuvPZXftK5RXOwgiiNRR1hvCKZTHpBrH1DyPPr47QagNcu
         it/c/fyEMVsR3G9uECalYRkZZXeHLqEzeJuDbN4ZkdzDYIiFu1xenbF/kpEvZUSOS9hr
         ktVY16eOI48NnkhcmusljSUNCddY85hA4sxhIi4p6Y7P/lnlsqFKgJY2exW/TJs1SYu3
         hnrCU8X9PoU5pB+ECWl0hFQyDiB0DGi7XSqxjac4B/Ml5jcNruBew2BicwdFTKBNl70a
         gnMQ==
X-Forwarded-Encrypted: i=1; AJvYcCULmctT9JK/PRsuv0a7iGMfv9R4WkE6aiYUuuLXfiyg5glpBMsZgW0SHqvkpToaoRJVMMb+ImYN@vger.kernel.org
X-Gm-Message-State: AOJu0YyQjAwdfahS8BVTBY1+vZeRNJ0IKebtEhZOjsxl32FebR+4yk0R
	yRU+4fzkDPzi24IlgCDQoXOU+sZayYLs8rlsAxtFL+QUKHBYygskyZZ9hQ8OcXvZ1kqxgmUg3Av
	Vn9WvOsXsHOpwxOfGciojZC6P69Um26s=
X-Gm-Gg: AZuq6aIz9XpK29QlWqa/rNyz9/9rkQ26zwssKjbWoggitAtbAOvNUu3yQ3THU1RU2bO
	MXQc4/X86hixRRTXsgAeVqB2pewj7ZOEu4fBuCwr1oD0suCGry8opVJ8OOd+INu6ZnGKmCJxr48
	8L7R4lJQGplSPROVSJr8YcZVLKaz6N2/1/C0OteV71jFxTOtP3j93K+uU7IhbgGTVdk9qIKpLQt
	cZQAjmQ+RuJm3sRQN264N1phgTgQLBwEQSzFkG7dZEVL6qPas9f76pxmsU4sgoZkFMV
X-Received: by 2002:a05:6512:b0a:b0:59d:deb3:8bd5 with SMTP id
 2adb3069b0e04-59de4a3892bmr1010651e87.48.1769174677308; Fri, 23 Jan 2026
 05:24:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110042249.31960-1-jianyuew@nvidia.com> <20260122114242.72139-1-wujianyue000@gmail.com>
 <87ec59f7-2d76-4c7a-a2b0-57bc4e801d1d@gmail.com>
In-Reply-To: <87ec59f7-2d76-4c7a-a2b0-57bc4e801d1d@gmail.com>
From: Jianyue Wu <wujianyue000@gmail.com>
Date: Fri, 23 Jan 2026 21:24:26 +0800
X-Gm-Features: AZwV_QjMT56dui_B6kAZP1oU-LmaRozN4fxC4YhZzZM1bcpR5mH3Bc7b9_YZ51o
Message-ID: <CAJxJ_jjGS39doSXGn7rxX_OmfLni=5YFwbucV7UxK-KMH937uQ@mail.gmail.com>
Subject: Re: [PATCH v3] mm: optimize stat output for 11% sys time reduce
To: JP Kobryn <inwardvessel@gmail.com>
Cc: akpm@linux-foundation.org, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13402-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wujianyue000@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 982F876358
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 4:14=E2=80=AFPM JP Kobryn <inwardvessel@gmail.com> =
wrote:
>
> On 1/22/26 3:42 AM, Jianyue Wu wrote:
> > Replace seq_printf/seq_buf_printf with lightweight helpers to avoid
> > printf parsing in memcg stats output.
>
> Hi Jianyue,
> I gave this patch a run and can confirm the perf gain. I left comments
> on reducing the amount of added lines so that it better resembles the
> existing code.
>
> Tested-by: JP Kobryn <inwardvessel@gmail.com>
>
Great, and thanks for the detailed review!

>
> There's a recurring pattern of 1) put name, 2) put separator, 3) put
> value. Instead of adding so many new lines, I wonder if you could use a
> function or macro that accepts: char *name, char sep, u64 val. You could
> then use it as a replacement for seq_printf() and avoid the extra added
> lines here and throughout this patch.
>
That's a good idea! Yes, if we use sep, then many places can use the
same function.

> > +     memory_limit =3D (u64)memory * PAGE_SIZE;
> > +     memsw_limit =3D (u64)memsw * PAGE_SIZE;
>
> I don't think in this case these new local variables are improving
> readability.
>
Agree, will remove it. Previously I wanted to keep them inside 80 columns,
as a hack:) Indent is not so easy to change.

> > +             seq_buf_puts(s, "total_");
> > +             memcg_seq_buf_put_name_val(s, memcg1_stat_names[i], (u64)=
nr);
>
> I would try and combine these 2 calls into 1 if possible. If the diff
> has close to a -1:+1 line change in places where seq_buf_printf() is
> replaced with some helper, it would reduce the noisiness. This applies
> to other areas where a prefix is put before calling a new helper.
>
Agree, I think we can add a prefix param here 0) prefix, 1) put name,
2) put separator, 3) put value. So we can use a common API.

> > +     u64 oom_kill;
> > +
> > +     memcg_seq_put_name_val(sf, "oom_kill_disable",
> > +                            READ_ONCE(memcg->oom_kill_disable));
> > +     memcg_seq_put_name_val(sf, "under_oom", (bool)memcg->under_oom);
> >
> > -     seq_printf(sf, "oom_kill_disable %d\n", READ_ONCE(memcg->oom_kill=
_disable));
> > -     seq_printf(sf, "under_oom %d\n", (bool)memcg->under_oom);
> > -     seq_printf(sf, "oom_kill %lu\n",
> > -                atomic_long_read(&memcg->memory_events[MEMCG_OOM_KILL]=
));
> > +     oom_kill =3D atomic_long_read(&memcg->memory_events[MEMCG_OOM_KIL=
L]);
> > +     memcg_seq_put_name_val(sf, "oom_kill", oom_kill);
>
> New local variable just adding extra lines.
>
Agree, will remove it.

> > +void memcg_seq_put_name_val(struct seq_file *m, const char *name, u64 =
val)
> > +{
> > +     seq_puts(m, name);
> > +     /* need a space between name and value */
> > +     seq_put_decimal_ull(m, " ", val);
> > +     seq_putc(m, '\n');
>
> I think seq_put* calls normally don't imply a newline. Maybe change the
> name to reflect, like something with "print"? Also, it's not really
> memcg specific.
>
> This function has a space as a separator. Earlier in your diff you were
> using '=3D'. A separator parameter could allow this func to be used
> elsewhere, but you'd have to manage the newline somehow. Maybe a newline
> wrapper?
I think a newline wrapper API might be an extra complexity, maybe this time
I'll keep changes only for which has a newline, places which still
don't have newline,
like memory.numa_stats print still kept using seq_printf() API.
But not sure how perf gain will be, I will test in the next version.

> > +void memcg_seq_buf_put_name_val(struct seq_buf *s, const char *name, u=
64 val)
> > +{
> > +     char num_buf[MEMCG_DEC_U64_MAX_LEN];
> > +     int num_len;
> > +
> > +     num_len =3D num_to_str(num_buf, sizeof(num_buf), val, 0);
> > +     if (num_len <=3D 0)
> > +             return;
> > +
> > +     if (seq_buf_puts(s, name))
> > +             return;
> > +     if (seq_buf_putc(s, ' '))
> > +             return;
>
> Can num_buf[0] just be ' '? The length would have to be extended though.
> Not sure if saving a few seq_buf_putc() calls make a difference.
>
> > +     if (seq_buf_putmem(s, num_buf, num_len))
> > +             return;
> > +     seq_buf_putc(s, '\n');
>
> Similary, though I'm not sure if it even performs better, this call
> could be removed and can do num_buf[num_len+1] =3D '\n' (extend buf
> again).
>
> If you make the two changes above you can call seq_buf_putmem() last.
Good catch~ Embedding the separator and newline in num_buf reduces
function calls from 4 to 2, perfect!

> > +}
> > +
> >   static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_bu=
f *s)
> >   {
> >       int i;
> > +     u64 pgscan, pgsteal;
> >
> More extra local variables. You can save the lines instead.
>
Agree, will remove it.

> > @@ -4247,7 +4315,8 @@ static int peak_show(struct seq_file *sf, void *v=
, struct page_counter *pc)
> >       else
> >               peak =3D max(fd_peak, READ_ONCE(pc->local_watermark));
> >
> > -     seq_printf(sf, "%llu\n", peak * PAGE_SIZE);
> > +     seq_put_decimal_ull(sf, "", peak * PAGE_SIZE);
> > +     seq_putc(sf, '\n');
>
> Your benchmark mentions reading memory and numa stat files, but this
> function is not reached in those cases. Is this a hot path for you? If
> not, maybe just leave this and any others like it alone.
>
This path is not touched by memory.stat. Agree, will remove the change.

> > +     u64 low, high, max, oom, oom_kill;
> > +     u64 oom_group_kill, sock_throttled;
> > +
> Same, more new locals.
Will remove them.

> > +     u64 swap_high, swap_max, swap_fail;
> > +
> > +     swap_high =3D atomic_long_read(&memcg->memory_events[MEMCG_SWAP_H=
IGH]);
> > +     swap_max =3D atomic_long_read(&memcg->memory_events[MEMCG_SWAP_MA=
X]);
> > +     swap_fail =3D atomic_long_read(&memcg->memory_events[MEMCG_SWAP_F=
AIL]);
>
> Same, new local variables.
Will remove them.

