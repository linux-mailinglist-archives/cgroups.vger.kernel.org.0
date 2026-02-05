Return-Path: <cgroups+bounces-13718-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPMjBHTUhGlo5gMAu9opvQ
	(envelope-from <cgroups+bounces-13718-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 05 Feb 2026 18:33:40 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEF3F5F96
	for <lists+cgroups@lfdr.de>; Thu, 05 Feb 2026 18:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA5B130097F8
	for <lists+cgroups@lfdr.de>; Thu,  5 Feb 2026 17:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B4D2EE5FD;
	Thu,  5 Feb 2026 17:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSjlzV4o"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF5D2EC561
	for <cgroups@vger.kernel.org>; Thu,  5 Feb 2026 17:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770312729; cv=pass; b=KCc6kNLsedbWuHQkUjac8YwgzFK2GBYK95d9edCy/w+wPYJgckwUgXRZR5DF/q2rQvVFL23dvj1DxKewW+QoDXmCmgIgnlS6khVvUHHEijYKo2Xhqq8QRTkkXObO7aGTgLwJWhuW8dpmH3UsN9JS207gMAyF6Wa2Nf0AcMS6Xxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770312729; c=relaxed/simple;
	bh=srkGxczuFkspY/DAZ7nZc0JKAH9E1WZLJv7z2xrMMms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WW2GJhNwlhuiPtF520Z9iu9AtlgHccjOv6Zm71mekQkeEtmDka3BcHfixQu/134LedutoxDn6rQ6vAXjv7WlRcz857IyPTSZqstr9Ly9J5rcXGQ+PRzFJLdasRMMsp16tzktcC48v8vk4n9WYkbEn6O+Vrbu4yEzQKXxfHTNzTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSjlzV4o; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43622089851so823254f8f.3
        for <cgroups@vger.kernel.org>; Thu, 05 Feb 2026 09:32:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770312728; cv=none;
        d=google.com; s=arc-20240605;
        b=fAYYGrNulwriUnuD5Ct0l687J0oKnjqcS8UvDS9J+bzGqeLQGUqR2yzQVBx9oLcrtn
         bO9FnU3oapO45SFnf4w20naRloGzF114vmh7eUiRUGfDUr0A4otfIfifkBIVXQD+NC3R
         i/uoTfnxihoT7/36U5tBjwr9bGtiY6acd67pzzGK6Fy+3cGtlZE8wcn9pjbr4p+AufJe
         i8VSeo1qRCiRBJwOGa7Pd8hEakS2mFR2GKQzcqSDbm4h4BebN0ZZLWfkMDAQ/n0G4lmQ
         RAfziU2+Duhk+UKeN8yiiO81HTXzEYFvJyC7Vi9zKRueNmCOhpwSy47OqOPiyn9NMhhT
         PsEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g52qu0qGnFSGXKiEGpFnsfB+pG35rlmS3i3v56pM+jk=;
        fh=r1RBgChWQYgZMNGsoVbXK1owwhrx8sT5hcg9AlZnNDw=;
        b=SSQ35M8edZNp6ooDmMwaMyr17IpKM6j1du90kPcS959NKI7/lBhgUspattQeZ9xnVj
         7aoLI/eHyW3QQjV+Ayh4tE/NTGdRho9a6145izeGTTW1ZyvEy8ivVDEZW+Yy5ITdV5qr
         aQ0nrcGnIneVH7C/q6UDP7G26lv/fCJkZMtaxi6HbY9q4AqMDavKXjXdx3S0mCUJpMEy
         1bgAmvHq+Gi4nZ6wVzTMoE0diofOFgzI3bTSPyEVAwLVQxrU8a/t8ZB94SWyuQ2+gV4l
         EH6x3fDRFpfmLWr5Ax3y5OK3EfHNqEz/b/QluJ3MsxxstjAFPM3R4B1+tvN7N0UVyG7v
         srEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770312728; x=1770917528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g52qu0qGnFSGXKiEGpFnsfB+pG35rlmS3i3v56pM+jk=;
        b=iSjlzV4o0eDDxTTGZH//3uVj8Bh4RXEF9R48Ilm0MKU+8oh1vvljRbf6xvh3Iu0Lpi
         FnBmNS/gBCyOMFfl0adhp6Hs7dj9hU/dJDbD0Qrjw26aJaTuTyAlZm20cHrNmJ/ID0nr
         uZPfmZpovtTG3m5cp/vni+8F8KbD0DXiO09JD3xJICGXYR0pYs04YmgMV83DUucDe19h
         AvKx/J4/0usD9ctW9xHxsbsvJTXCIx90TOXbza7ezV1xvu31Iu/gyMQPb4114BIHW1Mz
         Vnv8Ig5tltJTe/2Rb4MTolk683YT6zdr/7sejC66Ku2BXtY605mUJxANe9mXugSUzBfV
         spFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770312728; x=1770917528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g52qu0qGnFSGXKiEGpFnsfB+pG35rlmS3i3v56pM+jk=;
        b=BRDoAjQvaB2QX+au8di29iw+dLijyhze7snw5jPTbdedAHQIP/3UgxEnGxWN+5UMlU
         pR+V/wugj0jkbX0TyJMTQiKO6o4c826fsKz92RnCHpwhd/3Z3XVIJPmh2ak8Rq8zNv1t
         1Rn4xaoO+5AxwLi6dXaqR1beTLk2TbUIihg6E4pmAf+tWy5CvtVxLUGZ2MrTUqYM4CfR
         uXQej56N8vUXCz6dBdm4TqRuvl0ku8h9iyiLHSyuGZhLbZ447WSzBL70ojUufOVW/1ln
         iuOZJYjEWVDzTJpt5zPgYs+n9hnS3Tq14aCDmkkCtqUSuMkkbQoTZztZrE6F3fCUnoc5
         DPUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW173GxmPIn0MP2g54rrvgaxSyPd6EvdB9ESkoC3v3xYbfrKBq0LH2os+OAHd6ggnTSj+Mw1DWk@vger.kernel.org
X-Gm-Message-State: AOJu0YyIjUx/qYCrNP8yEQOWhlxzRX+gZlKgx8MaqcYe/vTMs0y1LBOw
	VHM6EQ+HY5rrfgRjVR9JBdT7LWsEKqpBnd0uy90vVJYAZybg2eOGYrNHlt7WkkZbkE6w5IC5Uia
	99sXffRirXR8q3VKRvWMJLKgaXGqw9+U=
X-Gm-Gg: AZuq6aIJtktxKcRQEJuPhjPztAHkYh+TcWnkHbCUFeaFSaN7ueEReoLLyQqsLDlweHg
	ZHTjAptwLHwiKiQ9BNs7hsuIoY2wlsmQOumiK7PEoEorGovh/ZIIJFMWWgdrbTO9j7hVG9xY01p
	fRKn0YCn8rM2DzPtLzoX9LZwFt0W2IseCaywf14vDv8383mP7N8JkzFUPijXBfUwZ4afFLge+58
	k6TsUVPncDl5i0VGMpkSJlmWAU/b1oKb+TVo2wqRyC3qxIAuQszp//GCL97rYk+eo/TumUnBEw1
	VPQHEG7OvQMhuizz+ucr8o8L5P7jX1YIZbtZwm4kYCHsKYK2gY4=
X-Received: by 2002:a05:6000:2210:b0:432:c0e8:4a33 with SMTP id
 ffacd0b85a97d-43629341477mr32789f8f.22.1770312727591; Thu, 05 Feb 2026
 09:32:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205053013.25134-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260205053013.25134-1-jiayuan.chen@linux.dev>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 5 Feb 2026 09:31:54 -0800
X-Gm-Features: AZwV_QjD6TkEI4CsNnehMc1v_KPguXieQKuSceu0vgbdRjFfP_QTgXPulDlKd_8
Message-ID: <CAKEwX=PMQ1aYWr36XKG7oup3diBXb5vjV=fGZeTmYcx+ebmMtQ@mail.gmail.com>
Subject: Re: [PATCH v1] mm: zswap: add per-memcg stat for incompressible pages
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: linux-mm@kvack.org, Jiayuan Chen <jiayuan.chen@shopee.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chris Li <chrisl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13718-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5FEF3F5F96
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 9:31=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
>
> The global zswap_stored_incompressible_pages counter was added in commit
> dca4437a5861 ("mm/zswap: store <PAGE_SIZE compression failed page as-is")
> to track how many pages are stored in raw (uncompressed) form in zswap.
> However, in containerized environments, knowing which cgroup is
> contributing incompressible pages is essential for effective resource
> management.
>
> Add a new memcg stat 'zswpraw' to track incompressible pages per cgroup.
> This helps administrators and orchestrators to:
>
> 1. Identify workloads that produce incompressible data (e.g., encrypted
>    data, already-compressed media, random data) and may not benefit from
>    zswap.
>
> 2. Make informed decisions about workload placement - moving
>    incompressible workloads to nodes with larger swap backing devices
>    rather than relying on zswap.
>
> 3. Debug zswap efficiency issues at the cgroup level without needing to
>    correlate global stats with individual cgroups.
>
> While the compression ratio can be estimated from existing stats
> (zswap / zswapped * PAGE_SIZE), this doesn't distinguish between
> "uniformly poor compression" and "a few completely incompressible pages
> mixed with highly compressible ones". The zswpraw stat provides direct
> visibility into the latter case.

I personally agree. This is especially useful for multi-tenants
setups, where different workloads can have different compressibility,
which can muddy the waters, and might prefer different swapping
treatment (disk swapping, zswapping, zswap + disk swap through zswap
shrinker). It might also give us data to extend zswap (zswap
compressibility-based rejection, or different compression levels).

Naming is a bit off though, but I'm not a native English speaker :)
I think Chris Li pointed the out the necessity of per-memcg counters too:

https://lore.kernel.org/linux-mm/CAF8kJuONDFj4NAksaR4j_WyDbNwNGYLmTe-o76rqU=
17La=3DnkOw@mail.gmail.com/

Can you add this to the patch changelog in later versions? :)

+ Chris Li
>
> Changes
> -------
>
> 1. Add zswap_is_raw() helper (include/linux/zswap.h)
>    - Abstract the PAGE_SIZE comparison logic for identifying raw entries
>    - Keep the incompressible check in one place for maintainability
>
> 2. Add MEMCG_ZSWAP_RAW stat definition (include/linux/memcontrol.h,
>    mm/memcontrol.c)
>    - Add MEMCG_ZSWAP_RAW to memcg_stat_item enum
>    - Register in memcg_stat_items[] and memory_stats[] arrays
>    - Export as "zswpraw" in memory.stat
>
> 3. Update statistics accounting (mm/memcontrol.c, mm/zswap.c)
>    - Track MEMCG_ZSWAP_RAW in obj_cgroup_charge/uncharge_zswap()
>    - Use zswap_is_raw() helper in zswap.c for consistency
>
> Test
> ----
>
> I wrote a simple test program[1] that allocates memory and compresses it
> with zstd, so kernel zswap cannot compress further.
>
>   $ cgcreate -g memory:test
>   $ cgexec -g memory:test ./test_zswpraw &
>   $ cat /sys/fs/cgroup/test/memory.stat | grep zswp
>   zswpraw 0
>   zswpin 0
>   zswpout 0
>   zswpwb 0
>
>   $ echo "100M" > /sys/fs/cgroup/test/memory.reclaim
>   $ cat /sys/fs/cgroup/test/memory.stat | grep zswp
>   zswpraw 104800256
>   zswpin 0
>   zswpout 51222
>   zswpwb 0
>
>   $ pkill test_zswpraw
>   $ cat /sys/fs/cgroup/test/memory.stat | grep zswp
>   zswpraw 0
>   zswpin 1
>   zswpout 51222
>   zswpwb 0
>
> [1] https://gist.github.com/mrpre/00432c6154250326994fbeaf62e0e6f1

Would be nice if some versions of this can be turned into a selftest :)

Instead of reading zstd data, you can read from /dev/urandom. I found
those to be incompressible, usually.

Feel free to send this as a follow-up patch, but would love to see it :)

>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> ---
>  include/linux/memcontrol.h | 1 +
>  include/linux/zswap.h      | 9 +++++++++
>  mm/memcontrol.c            | 6 ++++++
>  mm/zswap.c                 | 6 +++---
>  4 files changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index b6c82c8f73e1..83d1328f81d1 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -39,6 +39,7 @@ enum memcg_stat_item {
>         MEMCG_KMEM,
>         MEMCG_ZSWAP_B,
>         MEMCG_ZSWAPPED,
> +       MEMCG_ZSWAP_RAW,
>         MEMCG_NR_STAT,
>  };
>
> diff --git a/include/linux/zswap.h b/include/linux/zswap.h
> index 30c193a1207e..94f84b154b71 100644
> --- a/include/linux/zswap.h
> +++ b/include/linux/zswap.h
> @@ -7,6 +7,15 @@
>
>  struct lruvec;
>
> +/*
> + * Check if a zswap entry is stored in raw (uncompressed) form.
> + * This happens when compression doesn't reduce the size.
> + */
> +static inline bool zswap_is_raw(size_t size)
> +{
> +       return size =3D=3D PAGE_SIZE;
> +}
> +
>  extern atomic_long_t zswap_stored_pages;
>
>  #ifdef CONFIG_ZSWAP
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 007413a53b45..32fb801530a3 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -341,6 +341,7 @@ static const unsigned int memcg_stat_items[] =3D {
>         MEMCG_KMEM,
>         MEMCG_ZSWAP_B,
>         MEMCG_ZSWAPPED,
> +       MEMCG_ZSWAP_RAW,

not sure how I feel about the naming, but I don't have a recommendation :)

>  };
>
>  #define NR_MEMCG_NODE_STAT_ITEMS ARRAY_SIZE(memcg_node_stat_items)
> @@ -1346,6 +1347,7 @@ static const struct memory_stat memory_stats[] =3D =
{
>  #ifdef CONFIG_ZSWAP
>         { "zswap",                      MEMCG_ZSWAP_B                   }=
,
>         { "zswapped",                   MEMCG_ZSWAPPED                  }=
,
> +       { "zswpraw",                    MEMCG_ZSWAP_RAW                 }=
,
>  #endif
>         { "file_mapped",                NR_FILE_MAPPED                  }=
,
>         { "file_dirty",                 NR_FILE_DIRTY                   }=
,
> @@ -5458,6 +5460,8 @@ void obj_cgroup_charge_zswap(struct obj_cgroup *obj=
cg, size_t size)
>         memcg =3D obj_cgroup_memcg(objcg);
>         mod_memcg_state(memcg, MEMCG_ZSWAP_B, size);
>         mod_memcg_state(memcg, MEMCG_ZSWAPPED, 1);
> +       if (zswap_is_raw(size))
> +               mod_memcg_state(memcg, MEMCG_ZSWAP_RAW, 1);
>         rcu_read_unlock();
>  }
>
> @@ -5481,6 +5485,8 @@ void obj_cgroup_uncharge_zswap(struct obj_cgroup *o=
bjcg, size_t size)
>         memcg =3D obj_cgroup_memcg(objcg);
>         mod_memcg_state(memcg, MEMCG_ZSWAP_B, -size);
>         mod_memcg_state(memcg, MEMCG_ZSWAPPED, -1);
> +       if (zswap_is_raw(size))
> +               mod_memcg_state(memcg, MEMCG_ZSWAP_RAW, -1);
>         rcu_read_unlock();
>  }
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 3d2d59ac3f9c..54ab4d126f64 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -723,7 +723,7 @@ static void zswap_entry_free(struct zswap_entry *entr=
y)
>                 obj_cgroup_uncharge_zswap(entry->objcg, entry->length);
>                 obj_cgroup_put(entry->objcg);
>         }
> -       if (entry->length =3D=3D PAGE_SIZE)
> +       if (zswap_is_raw(entry->length))
>                 atomic_long_dec(&zswap_stored_incompressible_pages);
>         zswap_entry_cache_free(entry);
>         atomic_long_dec(&zswap_stored_pages);
> @@ -941,7 +941,7 @@ static bool zswap_decompress(struct zswap_entry *entr=
y, struct folio *folio)
>         zs_obj_read_sg_begin(pool->zs_pool, entry->handle, input, entry->=
length);
>
>         /* zswap entries of length PAGE_SIZE are not compressed. */
> -       if (entry->length =3D=3D PAGE_SIZE) {
> +       if (zswap_is_raw(entry->length)) {
>                 WARN_ON_ONCE(input->length !=3D PAGE_SIZE);
>                 memcpy_from_sglist(kmap_local_folio(folio, 0), input, 0, =
PAGE_SIZE);
>                 dlen =3D PAGE_SIZE;
> @@ -1448,7 +1448,7 @@ static bool zswap_store_page(struct page *page,
>                 obj_cgroup_charge_zswap(objcg, entry->length);
>         }
>         atomic_long_inc(&zswap_stored_pages);
> -       if (entry->length =3D=3D PAGE_SIZE)
> +       if (zswap_is_raw(entry->length))
>                 atomic_long_inc(&zswap_stored_incompressible_pages);
>
>         /*
> --
> 2.43.0
>

Those nits aside, LGTM.
Acked-by: Nhat Pham <nphamcs@gmail.com>

I'll leave the naming suggestion to Yosry and Johannes ;)

