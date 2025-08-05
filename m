Return-Path: <cgroups+bounces-8983-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01206B1B7CF
	for <lists+cgroups@lfdr.de>; Tue,  5 Aug 2025 17:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E0AC17AFDD
	for <lists+cgroups@lfdr.de>; Tue,  5 Aug 2025 15:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C5C289820;
	Tue,  5 Aug 2025 15:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aGO3xRll"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1822737F6
	for <cgroups@vger.kernel.org>; Tue,  5 Aug 2025 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754409264; cv=none; b=H2kHcKbMFUulBUacnVEzHCUIEzos4lajqKHiRHmdnPqoZQO2ALXSh7g7NmEplaanY3ZKkVEnUOlnrH/smTuB8P216VB1gA7mSoUTZ4GTLe3JC63MAONx07ZkhwUgmf0ZJ0UTzGmGFGT+8wcNGnIyzazTmbSBbHhXtGo0rlmMahA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754409264; c=relaxed/simple;
	bh=vNNJauOKZGwfoUOczIoeQj5UEZzfkBSWbLXemTczg+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tf1/ukWA5NdFoYC4ZI4wTQlpj3Zb0jW7vxGegWjPQ+F3Oq4LUom3mrlxD94HPcl7XU0askc1/Ouc+OuxPjLLEv7STtdzMBafS2ITCq9qr/BgTIcSZBFqDjuOC/yuTHXvwedNTRew8BGY2j0qgbW1CdeqUljfbHJ/mfz3Ga+6y5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aGO3xRll; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-320dfa8cfa3so4702973a91.3
        for <cgroups@vger.kernel.org>; Tue, 05 Aug 2025 08:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754409262; x=1755014062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXmcYBuTBSIC3cXLyf6AFT7dpi3YTNsScaWP3ZbN8Fs=;
        b=aGO3xRllOsjDIJjcPhtpEjrxWg75XDEjsWHK9MYLi2HVONa/9hXAovAIWd5HzX+LJg
         Ox2MRIP8G0zhfIUYuiMlQg4ELu8Ecp7RQOqiEqsRr2IJqqQKx8RetG186iqBFDlLPZIh
         esDUh9OfZ/MQWW+70iGwOqbsgYUFeom+4UNYFUSEaAcJ4HMIN1X7xu8p25PuERsZYpxF
         4J+0kC/fHUZNJ2hv8BnCUVvkn0B5cspYD0z4v8i3nztlzcU3a77v0ZAogyoET0owRofi
         BQXo1u03R3LL5e973Hu/ELccKb6iXgnNhalYvzUrWBOg1ScOTCoXqdHBhOyA67y78P8L
         L7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754409262; x=1755014062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DXmcYBuTBSIC3cXLyf6AFT7dpi3YTNsScaWP3ZbN8Fs=;
        b=DwwDpJu5f6i4HRmk7C1uT0H0fvuSK+AGuI7PLvkp9gqfZrYyh77yx1sVm8gX6qKvW7
         e20Ugg8j6v6CiDtgokNqay5BBxSbNWgu1S9z/R2NyyUuIhrBvHU4spaYnz7AZL2S4293
         fL6/iFEFzwB6dcQ/1j7DysdmN2FtII7sEmX3Eqhkm/P5h/6aylhPxJWJbqmFUm4qkHol
         zy5npRo7yoVdyzaAmZFnyQl16gQbx+IeqeuVgg4CanSz6xHP3xP6Z/7+/JNYysVY974Q
         E0gTI/Ynjmvej3jZGNPzxHjieN0CQTJCoJ5wM2RRln1Qk/LZyY5HF0e3vo2uT1mUS0bg
         hICA==
X-Forwarded-Encrypted: i=1; AJvYcCWrAwWMlMBs31Uf6Xc0FbQSj3cfQ7JUb3uz4hNjvucPp+bJ7KgPGnXV8r+/IhYB7oR22TX+i8yF@vger.kernel.org
X-Gm-Message-State: AOJu0YwkxwtaZ2ip+OsAAlvpeum5IcdC6e1D1xSD3w/84ONXaycM3eBE
	fhsX5+OkO42A9ShqSbSyiTNkenxU5H0RlUYNubNOgT5KgYPm9XfwXhBrwXDJVf9FBZoX6nz6cOT
	8Dp6KJuezonT/OlxkQY+fKAV2nAZzLUE2MT9h0+l3
X-Gm-Gg: ASbGnct2z/HOlirMTr//JxTbutdDPozCAgyiZVaYuWUsgmEDzyujpfx85+ikvAFEqNG
	RjPQlRiXzixaPaTTZlqpo3ajsiw+QMyYQKGMzwATY2oSHyLFIRIXGhxcaHNABynE88fPy7b/Z6l
	7ddJjwjvI3l2c8Gg9c/vUVKrEwyngvVGI/XgruOZXKUmmUNLpcvNVNsP16DC54BS13XEf7k/nd4
	Pffd0s=
X-Google-Smtp-Source: AGHT+IGDJF1zGd354VGsk1JYD0WGO/qVAFK/iq6mSfdssGAQaDT7Q3MQvezrFrpqbdBymBKwtXs9Ld7000cDegyNrxQ=
X-Received: by 2002:a17:90b:224e:b0:31f:1739:b541 with SMTP id
 98e67ed59e1d1-321162cbc80mr19242734a91.29.1754409261039; Tue, 05 Aug 2025
 08:54:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805064429.77876-1-daniel.sedlak@cdn77.com>
In-Reply-To: <20250805064429.77876-1-daniel.sedlak@cdn77.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 5 Aug 2025 08:54:08 -0700
X-Gm-Features: Ac12FXwC7xFTjCLjGN458qKNnLIHpU-rBIAK63QMImo5RiuLdxc4hroNKGTATNY
Message-ID: <CAAVpQUCyM2x5a=w5MG9c5GDsHWX=Vse9qDP0URu6q9mSP0PD3Q@mail.gmail.com>
Subject: Re: [PATCH v4] memcg: expose socket memory pressure in a cgroup
To: Daniel Sedlak <daniel.sedlak@cdn77.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, netdev@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Matyas Hurtik <matyas.hurtik@cdn77.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 11:50=E2=80=AFPM Daniel Sedlak <daniel.sedlak@cdn77.=
com> wrote:
>
> This patch is a result of our long-standing debug sessions, where it all
> started as "networking is slow", and TCP network throughput suddenly
> dropped from tens of Gbps to few Mbps, and we could not see anything in
> the kernel log or netstat counters.
>
> Currently, we have two memory pressure counters for TCP sockets [1],
> which we manipulate only when the memory pressure is signalled through
> the proto struct [2]. However, the memory pressure can also be signaled
> through the cgroup memory subsystem, which we do not reflect in the
> netstat counters. In the end, when the cgroup memory subsystem signals
> that it is under pressure, we silently reduce the advertised TCP window
> with tcp_adjust_rcv_ssthresh() to 4*advmss, which causes a significant
> throughput reduction.
>
> Keep in mind that when the cgroup memory subsystem signals the socket
> memory pressure, it affects all sockets used in that cgroup.
>
> This patch exposes a new file for each cgroup in sysfs which signals
> the cgroup socket memory pressure. The file is accessible in
> the following path.
>
>   /sys/fs/cgroup/**/<cgroup name>/memory.net.socket_pressure
>
> The output value is a cumulative sum of microseconds spent
> under pressure for that particular cgroup.
>
> Link: https://elixir.bootlin.com/linux/v6.15.4/source/include/uapi/linux/=
snmp.h#L231-L232 [1]
> Link: https://elixir.bootlin.com/linux/v6.15.4/source/include/net/sock.h#=
L1300-L1301 [2]
> Co-developed-by: Matyas Hurtik <matyas.hurtik@cdn77.com>
> Signed-off-by: Matyas Hurtik <matyas.hurtik@cdn77.com>
> Signed-off-by: Daniel Sedlak <daniel.sedlak@cdn77.com>
> ---
> Changes:
> v3 -> v4:
> - Add documentation
> - Expose pressure as cummulative counter in microseconds
> - Link to v3: https://lore.kernel.org/netdev/20250722071146.48616-1-danie=
l.sedlak@cdn77.com/
>
> v2 -> v3:
> - Expose the socket memory pressure on the cgroups instead of netstat
> - Split patch
> - Link to v2: https://lore.kernel.org/netdev/20250714143613.42184-1-danie=
l.sedlak@cdn77.com/
>
> v1 -> v2:
> - Add tracepoint
> - Link to v1: https://lore.kernel.org/netdev/20250707105205.222558-1-dani=
el.sedlak@cdn77.com/
>
>  Documentation/admin-guide/cgroup-v2.rst |  7 +++++++
>  include/linux/memcontrol.h              |  2 ++
>  mm/memcontrol.c                         | 15 +++++++++++++++
>  mm/vmpressure.c                         |  9 ++++++++-
>  4 files changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admi=
n-guide/cgroup-v2.rst
> index 0cc35a14afbe..c810b449fb3d 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1884,6 +1884,13 @@ The following nested keys are defined.
>         Shows pressure stall information for memory. See
>         :ref:`Documentation/accounting/psi.rst <psi>` for details.
>
> +  memory.net.socket_pressure
> +       A read-only single value file showing how many microseconds
> +       all sockets within that cgroup spent under pressure.
> +
> +       Note that when the sockets are under pressure, the networking
> +       throughput can be significantly degraded.
> +
>
>  Usage Guidelines
>  ~~~~~~~~~~~~~~~~
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 87b6688f124a..6a1cb9a99b88 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -252,6 +252,8 @@ struct mem_cgroup {
>          * where socket memory is accounted/charged separately.
>          */
>         unsigned long           socket_pressure;
> +       /* exported statistic for memory.net.socket_pressure */
> +       unsigned long           socket_pressure_duration;
>
>         int kmemcg_id;
>         /*
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 902da8a9c643..8e299d94c073 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3758,6 +3758,7 @@ static struct mem_cgroup *mem_cgroup_alloc(struct m=
em_cgroup *parent)
>         INIT_LIST_HEAD(&memcg->swap_peaks);
>         spin_lock_init(&memcg->peaks_lock);
>         memcg->socket_pressure =3D jiffies;
> +       memcg->socket_pressure_duration =3D 0;
>         memcg1_memcg_init(memcg);
>         memcg->kmemcg_id =3D -1;
>         INIT_LIST_HEAD(&memcg->objcg_list);
> @@ -4647,6 +4648,15 @@ static ssize_t memory_reclaim(struct kernfs_open_f=
ile *of, char *buf,
>         return nbytes;
>  }
>
> +static int memory_socket_pressure_show(struct seq_file *m, void *v)
> +{
> +       struct mem_cgroup *memcg =3D mem_cgroup_from_seq(m);
> +
> +       seq_printf(m, "%lu\n", READ_ONCE(memcg->socket_pressure_duration)=
);
> +
> +       return 0;
> +}
> +
>  static struct cftype memory_files[] =3D {
>         {
>                 .name =3D "current",
> @@ -4718,6 +4728,11 @@ static struct cftype memory_files[] =3D {
>                 .flags =3D CFTYPE_NS_DELEGATABLE,
>                 .write =3D memory_reclaim,
>         },
> +       {
> +               .name =3D "net.socket_pressure",
> +               .flags =3D CFTYPE_NOT_ON_ROOT,
> +               .seq_show =3D memory_socket_pressure_show,
> +       },
>         { }     /* terminate */
>  };
>
> diff --git a/mm/vmpressure.c b/mm/vmpressure.c
> index bd5183dfd879..1e767cd8aa08 100644
> --- a/mm/vmpressure.c
> +++ b/mm/vmpressure.c
> @@ -308,6 +308,8 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, =
bool tree,
>                 level =3D vmpressure_calc_level(scanned, reclaimed);
>
>                 if (level > VMPRESSURE_LOW) {
> +                       unsigned long socket_pressure;
> +                       unsigned long jiffies_diff;
>                         /*
>                          * Let the socket buffer allocator know that
>                          * we are having trouble reclaiming LRU pages.
> @@ -316,7 +318,12 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg,=
 bool tree,
>                          * asserted for a second in which subsequent
>                          * pressure events can occur.
>                          */
> -                       WRITE_ONCE(memcg->socket_pressure, jiffies + HZ);
> +                       socket_pressure =3D jiffies + HZ;
> +
> +                       jiffies_diff =3D min(socket_pressure - READ_ONCE(=
memcg->socket_pressure), HZ);
> +                       memcg->socket_pressure_duration +=3D jiffies_to_u=
secs(jiffies_diff);

WRITE_ONCE() is needed here.


> +
> +                       WRITE_ONCE(memcg->socket_pressure, socket_pressur=
e);
>                 }
>         }
>  }
>
> base-commit: e96ee511c906c59b7c4e6efd9d9b33917730e000
> --
> 2.39.5
>

