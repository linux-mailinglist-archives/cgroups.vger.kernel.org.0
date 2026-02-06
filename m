Return-Path: <cgroups+bounces-13756-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MO95IDlwhmnONAQAu9opvQ
	(envelope-from <cgroups+bounces-13756-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 23:50:33 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B76103F63
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 23:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B7353045032
	for <lists+cgroups@lfdr.de>; Fri,  6 Feb 2026 22:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F09130E831;
	Fri,  6 Feb 2026 22:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBenC7/p"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37103019A9
	for <cgroups@vger.kernel.org>; Fri,  6 Feb 2026 22:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770418219; cv=pass; b=be9qCmztRUpkIn/Q5ey6aaHl4LMfQOJVc0HkGW+jtdiXptz2Fdz1YJEjJNenrXtu1XB3JRVCLWQYe1mKJfwZOrcyOqMbBFCro7p76DOrTrrHbXIHMnpeBb/Z8QblwTU9obDpAUMA7CS3kukFpCShyD6rHMfWt392FjcB3Iw8S7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770418219; c=relaxed/simple;
	bh=iQtWeiSNgPEPdaYwgKsUPFq1PwMnhYeNxsLcE4bOo68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kaM5nkiAGhR/B6uDwG3dgxnQuZvvrayUEpI4GQE9/59h5bbsxFIczzU5kDRVfyGBZYu4wkL/2TeF2gcEY6jRRToO652O3iJOqTatJXhUzCjdSusSZOSMfXTjUP9wqcNK+L49TCcxa4r+oz+zeb51uUrePA1H9MeQONlh0hpiwMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBenC7/p; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4362e77d7fbso709727f8f.2
        for <cgroups@vger.kernel.org>; Fri, 06 Feb 2026 14:50:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770418217; cv=none;
        d=google.com; s=arc-20240605;
        b=BFMccgEB8FHqOFG/hEUxEQTfWCB9fYquYJHYGZhl/syKau0jmeCRjowtrPB79jHFTb
         Ohjofq8Dfzh4tIVTeStNyxMzV4uTlGR3XTI2sNh9JfCRY6/c8gI03yw0WYhs/Zn4Ep2/
         QWKemsqzg7x1aLt3NHNVyvHzfNEG2utIW/wEEMVCajghbuSDhsH6u1Se03jSpyuMpxdp
         KlGnqwm5nu5Euc6AykG3fIl3N9nrPnBILoiai/w40CR5OEU4JFNAWulkW4agzWOqzJ5s
         P5XVmWMcmOCULoJHDkCIaaldJjrYUBT0K/4uaDHVviKMWhephtST9cblk1N0IVNGhTYz
         5tIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pKIcE6GoeXBIyuDrXKVfe0dIRC3Ib5hok4aF2odJDyQ=;
        fh=BfBrpNa+IYwLhC1kq2j2+Nen1NKzQpPZG33DT9MXLw8=;
        b=TmuI51nRzz6thnC6kPHfxsH+8d82I0uwPpGMJGegSpPdrtkxsJJQgirKfKenXuz0na
         y5kAIhqH/AoXv5xXnokVh1+r/CkYDQLWfgNd9tCWey9609JOJc048/UQ1l0zMHBc6d+b
         ixQ9TP9GgWNMvrdOMm8Y2qEYVQWmE4CEsMLekY90HEwch/tplfMwvmYEPWg8zNPZ9wym
         pK023845AsToTSf4GazIfQiHUrlKwnFRiKREAGWQaJNye4jc6WbszyHsdvdVyyXt3KDk
         oamokNtJs6zVSwfj8k55Hnp01BrYyq/YXg70yHjcm6BYOwL2EtS12tqqyLQABwJIaQ68
         STGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770418217; x=1771023017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKIcE6GoeXBIyuDrXKVfe0dIRC3Ib5hok4aF2odJDyQ=;
        b=EBenC7/pYvhgt9VftkJ6bdSw/J54P0RsOVJ0hPcw6vvChUP6B7xn7sxeYoynCQcWdf
         OjB+8MaYsTVCUotPiDeZeMaiDBq8Rx5XM0v4q7QC3K3I5VFKNkE7mngVucC64zSFUHE2
         P6h1ARTEGoAPuxc8+/dd2nd4CibHOFwQpqz8T0SN8seS99m4HUcC5GhMQ+T5ViGpV82g
         oEFNst3YKi2BJQtBEZpuQDkJifbUod5XAVnE14b4nip1x8sSvZqRn7/MqhfEARIP4aEB
         EC3q2OG29GprPWWSdv4it6V7qtblXsM3cjQfJDUhw8mKNP+yv7BEAF0sDdejX6yfTyp2
         u7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770418217; x=1771023017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pKIcE6GoeXBIyuDrXKVfe0dIRC3Ib5hok4aF2odJDyQ=;
        b=g7/PKv/MOyIXAyj6SDJ2Lr83kiYT+DN+qX76/cAJ0aSKFogXWYnh1tQCowvfQcbN/m
         toTqFsLRAi6jlBeR9fSuB+Ez5T4DjkKBN7bRJmu2vb05HIa2Y/eGXqNwrzQwhsgn17pv
         Fz4X7FZQ+Pwb8iN5vV7rCca+Ca+5qvBzicANXe6aj5qxuPAHvHqlST6EAqQjaAwB1NoH
         sPIeIqL5NYlqBNhYnzDWL6nWu4xGdWWyL5fY4lZEEcyg4RbBTEM6c1mO/usentd+lASC
         LBEulZS/FGl+NDWq31wn7cUd0OUxtCkmaSGmlDMksKAZ/APDm4DR4Njt7wsiEAFOt9yI
         litA==
X-Forwarded-Encrypted: i=1; AJvYcCWDxs7MRxMdQjaMyfW1Yv4i9f+L2ICSzKxjw57C8n3bzahdb7KJa6JHB/j3/vynfJZlDvxXBw+4@vger.kernel.org
X-Gm-Message-State: AOJu0YyXLgsiq4CoS8df533Oop5at6799VYYKBnq2uyqIGNbSjBvbHtM
	Nkonx0oHQns/AR5ofv948e0YXNd/eOMoP4H2TkEIUxV01w6u80j4Fmvh+kMeEqmSADykUwulPDt
	bIN2Da9PQErjs1fhugYs6USHHR2FkDNc=
X-Gm-Gg: AZuq6aIZc0u6pi1W4lWgpPXpvLGdBDB79Z+fyzy00u55q1Rpz2dmXtQQk52ed0Nx9vB
	pjs5imxTb/IwKoDSxCC4+KL0cr610e8qJeFR1matlMxsSkQZ0lIhK84FLN9jqp2LCnvPQikXoK4
	JXletXgqKtlNEDk5q7c7nSgnuJMvrpa+aUnJDtV5dzZfJEizWpexx1v21cmZ/d8y3vjHIVZlTFl
	TQXX9rWwaj5NRXL9dDU0cOuuHFGr72rrFn4vfugPFRHpU9eYI9G+K55M9t8OwJZtIrZAPsdgOt+
	bWS7JQVNveXl7ZRt/Z3DhkOjtKBQ415Vec6MIIe+AQ78LXEUO6YHmFYTfEMWmuqgdEhV8A==
X-Received: by 2002:adf:ea06:0:b0:436:307c:b762 with SMTP id
 ffacd0b85a97d-436307cb87bmr1734201f8f.60.1770418216969; Fri, 06 Feb 2026
 14:50:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206072220.144008-1-jiayuan.chen@linux.dev> <20260206072220.144008-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260206072220.144008-3-jiayuan.chen@linux.dev>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 6 Feb 2026 14:50:05 -0800
X-Gm-Features: AZwV_QjoaGZjUJoZZAUbUNek4v2vd9XA09_63K25KesvtBZQTlzS_xae5VjsBQ0
Message-ID: <CAKEwX=MgvCHVMOWNprWu1xbQ6=CO4ok_sywH2Cgz05aT_pdZ5A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selftests/cgroup: add test for zswap
 incompressible pages
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: linux-mm@kvack.org, Jiayuan Chen <jiayuan.chen@shopee.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13756-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 39B76103F63
X-Rspamd-Action: no action

On Thu, Feb 5, 2026 at 11:22=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
>
> Add test_zswap_incompressible() to verify that the zswap_incomp memcg
> stat correctly tracks incompressible pages.
>
> The test allocates memory filled with random data from /dev/urandom,
> which cannot be effectively compressed by zswap. When this data is
> swapped out to zswap, it should be stored as-is and tracked by the
> zswap_incomp counter.
>
> The test verifies that:
> 1. Pages are swapped out to zswap (zswpout increases)
> 2. Incompressible pages are tracked (zswap_incomp increases)
>
> test:
> dd if=3D/dev/zero of=3D/swapfile bs=3D1M count=3D2048
> chmod 600 /swapfile
> mkswap /swapfile
> swapon /swapfile
> echo Y > /sys/module/zswap/parameters/enabled
>
> ./test_zswap
>  TAP version 13
>  1..8
>  ok 1 test_zswap_usage
>  ok 2 test_swapin_nozswap
>  ok 3 test_zswapin
>  ok 4 test_zswap_writeback_enabled
>  ok 5 test_zswap_writeback_disabled
>  ok 6 test_no_kmem_bypass
>  ok 7 test_no_invasive_cgroup_shrink
>  ok 8 test_zswap_incompressible
>  Totals: pass:8 fail:0 xfail:0 xpass:0 skip:0 error:0
>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> ---
>  tools/testing/selftests/cgroup/test_zswap.c | 96 +++++++++++++++++++++
>  1 file changed, 96 insertions(+)
>
> diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/=
selftests/cgroup/test_zswap.c
> index 64ebc3f3f203..8cb8a131357d 100644
> --- a/tools/testing/selftests/cgroup/test_zswap.c
> +++ b/tools/testing/selftests/cgroup/test_zswap.c
> @@ -5,6 +5,7 @@
>  #include <unistd.h>
>  #include <stdio.h>
>  #include <signal.h>
> +#include <fcntl.h>
>  #include <sys/sysinfo.h>
>  #include <string.h>
>  #include <sys/wait.h>
> @@ -574,6 +575,100 @@ static int test_no_kmem_bypass(const char *root)
>         return ret;
>  }
>
> +static int allocate_random_and_wait(const char *cgroup, void *arg)
> +{
> +       size_t size =3D (size_t)arg;
> +       char *mem;
> +       int fd;
> +       ssize_t n;
> +
> +       mem =3D malloc(size);
> +       if (!mem)
> +               return -1;
> +
> +       /* Fill with random data from /dev/urandom - incompressible */
> +       fd =3D open("/dev/urandom", O_RDONLY);
> +       if (fd < 0) {
> +               free(mem);
> +               return -1;
> +       }
> +
> +       for (size_t i =3D 0; i < size; ) {
> +               n =3D read(fd, mem + i, size - i);
> +               if (n <=3D 0)
> +                       break;
> +               i +=3D n;
> +       }
> +       close(fd);
> +
> +       /* Touch all pages to ensure they're faulted in */
> +       for (size_t i =3D 0; i < size; i +=3D 4096)
> +               mem[i] =3D mem[i];
> +
> +       /* Keep memory alive for parent to reclaim and check stats */
> +       pause();
> +       free(mem);
> +       return 0;
> +}
> +
> +static long get_zswap_incomp(const char *cgroup)
> +{
> +       return cg_read_key_long(cgroup, "memory.stat", "zswap_incomp ");
> +}
> +
> +/*
> + * Test that incompressible pages (random data) are tracked by zswap_inc=
omp.
> + *
> + * Since incompressible pages stored in zswap are charged at full PAGE_S=
IZE
> + * (no memory savings), we cannot rely on memory.max pressure to push th=
em
> + * into zswap. Instead, we allocate random data within memory.max, then =
use
> + * memory.reclaim to proactively push pages into zswap while checking th=
e stat
> + * before the child exits (zswap_incomp is a gauge that decreases on fre=
e).

I wonder if we can do MADV_PAGEOUT? Anyway, I'm fine with memory.reclaim to=
o.

> + */
> +static int test_zswap_incompressible(const char *root)
> +{
> +       int ret =3D KSFT_FAIL;
> +       char *test_group;
> +       long zswap_incomp;
> +       pid_t child_pid;
> +       int child_status;
> +
> +       test_group =3D cg_name(root, "zswap_incompressible_test");
> +       if (!test_group)
> +               goto out;
> +       if (cg_create(test_group))
> +               goto out;
> +       if (cg_write(test_group, "memory.max", "32M"))
> +               goto out;
> +
> +       child_pid =3D cg_run_nowait(test_group, allocate_random_and_wait,
> +                                 (void *)MB(4));
> +       if (child_pid < 0)
> +               goto out;
> +
> +       /* Wait for child to finish allocating */
> +       usleep(500000);
> +
> +       /* Proactively reclaim to push random pages into zswap */
> +       cg_write_numeric(test_group, "memory.reclaim", MB(4));
> +
> +       zswap_incomp =3D get_zswap_incomp(test_group);
> +       if (zswap_incomp <=3D 0) {
> +               ksft_print_msg("zswap_incomp not increased: %ld\n", zswap=
_incomp);
> +               goto out_kill;
> +       }
> +
> +       ret =3D KSFT_PASS;
> +
> +out_kill:
> +       kill(child_pid, SIGTERM);
> +       waitpid(child_pid, &child_status, 0);
> +out:
> +       cg_destroy(test_group);
> +       free(test_group);
> +       return ret;
> +}

LGTM :)

Acked-by: Nhat Pham <nphamcs@gmail.com>

