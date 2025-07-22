Return-Path: <cgroups+bounces-8818-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE05B0D26C
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 09:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B905F5471C3
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 07:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34392989B4;
	Tue, 22 Jul 2025 07:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YggC7/cU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC8B228CA9
	for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 07:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753168644; cv=none; b=g6zl4liC3fNO3/uxf+EG2nNAXx+D8jJPfDqhzLByKGpmsdWgPD+tiM31L/Qzq6jEMBfTSqvu1takwSo6hdcSaVstEW8gaRIr3cXkoyHqkT8+CV3s3tS4Wt+i0mHJsZj7I400tt6VC6SuHMgx+7dTgXuysxv/vQdZfCfHCoklcWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753168644; c=relaxed/simple;
	bh=/reFbip4z6HGdC1YN+8o0sVMfsy7eUF1tUMhdnKuuoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NBn4cLiaHo2pGsoTzZzNHAgSEzvvS1Y2B9xwA3PGW4kH7XgTlqyAW91lmiGClsxgE4pTwDpoepdHuH0QzkDKJyc8sdNuBPip9UOku4WHE3i5RiDwHsNisjuYO9vJzkdlWY8U3qR1MLWpUeqMmpzz56CWSANblFqhzxZuphsIENI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YggC7/cU; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ab644b8dc1so57033611cf.1
        for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 00:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753168642; x=1753773442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k18tpt6MzY4+EfMPJ8+KaJPrYaWfsW1gfyLbK9RchSQ=;
        b=YggC7/cU+JrycRjFVSlYO5fDWr/HMPrr4JSB2JCeVq7otMFXx/jJoKYEDOxg6TvK60
         o4Ur4AeIcW8yRdcEvja8QraNP6C+AvKouKFCX9UQJ/aH8xKWzGU30+B1fYYfbEmhN/dS
         dIhZnNGBPQnUQJ7x3z23kDoYqlVe+P16xLATwfZQiNqAbtrVlS+f4ZU0dGsE6PhPMaoz
         Kd83QmkyMlCSZEFw7dTiS+ynzALo3tNsEntChdfVkoixXgIpELIm722OpOc17AZNUtXM
         Tx0o7A+qVmw+L5xb0W/0iU5HeMCHmeybHyXUmXLbKxwE6qEf7+X4G4kxlCRrLNd2pYiH
         5/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753168642; x=1753773442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k18tpt6MzY4+EfMPJ8+KaJPrYaWfsW1gfyLbK9RchSQ=;
        b=XvRfz0/67z0K6qArWAC20lh0GK78iVDppHWdb2JOLXbkREK4b6akSqNu9pVcCOxG5I
         8+xm3Ny8E0HhiHrxzxrMwEvQMJNqEstKq1t2Q73jRu6Kbw+5nbiJ0IDVsM0AZXAVgWKi
         Jvoq998k7kV9/FKF35WQsouF1LDpITOAmFfka2WHWfpr8NMEZ0GVUUxrPepLxQnvEyRn
         no/CauK6RuX/mGpeg1a8cZvLtKMznO+QQtBhjzCqNfzF73k9QhteLhAeRmeoLe5Y03lS
         FuYR31QJK+EnZUZqBASZrqZBZuCplpiCkIhh2DOXpawyn+egh5cFQAvfLoSfMPzcLyRN
         WW3g==
X-Forwarded-Encrypted: i=1; AJvYcCUtt8kBd54Nlxzd3FjYE0lvKwu0QjbpKdep4tpjozN13l5pszjY+yTq0W0IdBeTEnvDIqtIVFPo@vger.kernel.org
X-Gm-Message-State: AOJu0YyAW0OPFjj6r0MOp6QJU966rJBPFoCQqZJsJt59D6afVmux9bHX
	OOuQIlkZJslUegz342IB5C9LMrgze/Ys7/pAhNU6vxdhzCHXHBVB+eK/DjmX0T9VpFbPMx8i2Og
	1PXwprrCFiiUpZW8AZDsELMebQTE1Kc7fzs1pm+XZ
X-Gm-Gg: ASbGncveDw31YO+IpfJ6udWdHo6ic92ajwfbeABLgR5AdqesB1QMWxYAngKOakGiIqk
	nd0oZhdmicXsCnqRjsfUTGIDElItqJLocURfNtnl0nRIbKiJnzB/M71EZ7TUOjOE8oMNc99Hatz
	RGa9LERm67bLJjtv3TfZEWrElXQRrQoAP54pY2fPPZhudiPTGqvWj2ZSq5FZKk+jORyHaAV8Zip
	bdpZA==
X-Google-Smtp-Source: AGHT+IEJqjlyXu7R2eB3u1viFPNlH5wWs/bl/JODZ7kqSRD8a+WDvay6gqWxv9EQQNnkoM6Gc34A9c4Zmm1eApzt1xc=
X-Received: by 2002:a05:622a:1999:b0:4a9:a2e6:da94 with SMTP id
 d75a77b69052e-4ab93ded0c2mr349747361cf.47.1753168641626; Tue, 22 Jul 2025
 00:17:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722071146.48616-1-daniel.sedlak@cdn77.com>
In-Reply-To: <20250722071146.48616-1-daniel.sedlak@cdn77.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Jul 2025 00:17:10 -0700
X-Gm-Features: Ac12FXxLrRoFnAV1nQaQbqwzGzX2Lv_Mk1B6brAV1S6ScCbjXeF5WMlq0NtjP-U
Message-ID: <CANn89i+sAgVOOoowNfqxv7+NrAa+8EzkWTVMP8LeGDJ23sFQpg@mail.gmail.com>
Subject: Re: [PATCH v3] memcg: expose socket memory pressure in a cgroup
To: Daniel Sedlak <daniel.sedlak@cdn77.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	David Ahern <dsahern@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, 
	netdev@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	Matyas Hurtik <matyas.hurtik@cdn77.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 12:12=E2=80=AFAM Daniel Sedlak <daniel.sedlak@cdn77=
.com> wrote:
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
> The output value is an integer matching the internal semantics of the
> struct mem_cgroup for socket_pressure. It is a periodic re-arm clock,
> representing the end of the said socket memory pressure, and once the
> clock is re-armed it is set to jiffies + HZ.
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
> v2 -> v3:
> - Expose the socket memory pressure on the cgroups instead of netstat
> - Split patch
> - Link: https://lore.kernel.org/netdev/20250714143613.42184-1-daniel.sedl=
ak@cdn77.com/
>
> v1 -> v2:
> - Add tracepoint
> - Link: https://lore.kernel.org/netdev/20250707105205.222558-1-daniel.sed=
lak@cdn77.com/
>
>
>  mm/memcontrol.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 902da8a9c643..8e8808fb2d7a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4647,6 +4647,15 @@ static ssize_t memory_reclaim(struct kernfs_open_f=
ile *of, char *buf,
>         return nbytes;
>  }
>
> +static int memory_socket_pressure_show(struct seq_file *m, void *v)
> +{
> +       struct mem_cgroup *memcg =3D mem_cgroup_from_seq(m);
> +
> +       seq_printf(m, "%lu\n", READ_ONCE(memcg->socket_pressure));
> +
> +       return 0;
> +}
> +
>  static struct cftype memory_files[] =3D {
>         {
>                 .name =3D "current",
> @@ -4718,6 +4727,11 @@ static struct cftype memory_files[] =3D {
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

It seems you forgot to update Documentation/admin-guide/cgroup-v2.rst

