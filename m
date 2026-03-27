Return-Path: <cgroups+bounces-15078-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id II0cBF6FxmmhLQUAu9opvQ
	(envelope-from <cgroups+bounces-15078-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 27 Mar 2026 14:25:50 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4F3345279
	for <lists+cgroups@lfdr.de>; Fri, 27 Mar 2026 14:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 32B453113092
	for <lists+cgroups@lfdr.de>; Fri, 27 Mar 2026 13:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579502E1EFC;
	Fri, 27 Mar 2026 13:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c/Qj1CAZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BLFCwvZR"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ACA3E9295
	for <cgroups@vger.kernel.org>; Fri, 27 Mar 2026 13:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774617349; cv=pass; b=CrkEulZrdW6s3wWnEJ7OVH6bXwLXTDBUj0zvCxPLBMD5SWCv8AgT3ylS44RVjfFH0CUZULiHbae7eyh2R2DrnvkUYDZBEiVw3ouipRZfL1celH7ZcbUXEpQ9kt+J+YIqsDK2cvD/SadDYSERzCQ3TxrIj2qyxTRBDz+zJSUXiiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774617349; c=relaxed/simple;
	bh=0qSPYpaceiOiGC0EdEYrehQ5ivuxCJL8Is+O1ASoOEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=me2w200EjEGotAQZm1x+WnVFJqpgTEZA2wdaNEd0Uo2VwCUWsRWPeuuxacaKioFCINrmo+n2DoJAHR+C7s+ieSvY7NWeihKbwPae8ovTx3RmAWwjEW01mnU8rTFqXR1e6Lh9pZJeQOyx0C/2PWFgzMnLaAigTAt6cEFIPwkKzxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c/Qj1CAZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BLFCwvZR; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774617346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/OVX1r9Iz0+z3/EtWsPL46cFf+Te6jgc3vVhsdqqxV4=;
	b=c/Qj1CAZnWfaEXG2UhK3XX2g+su2oJoXtrolczYd/3qIpga31hm/TmpbE9gUz1OADvGGBR
	bGDmOCHzXYhSJEAjUQupyY+fw5wId19RQJoxSeEPmbJjN02n9wOdFSNUd8fcRMiVexp02A
	xNFf+A11UfSnJ8w5A2I283W/fB5gwak=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-smoYy2ffMJ-nYpqZLBTQvw-1; Fri, 27 Mar 2026 09:15:44 -0400
X-MC-Unique: smoYy2ffMJ-nYpqZLBTQvw-1
X-Mimecast-MFC-AGG-ID: smoYy2ffMJ-nYpqZLBTQvw_1774617344
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7986c067508so47383867b3.2
        for <cgroups@vger.kernel.org>; Fri, 27 Mar 2026 06:15:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774617344; cv=none;
        d=google.com; s=arc-20240605;
        b=E515WU8v1zOIF0Jd8OBTaInpUO86FLWgRvPNuefpVTy1qik9WZfvEYu+RqOx+H2on/
         UUtf7Yl08hNmNH1RV2YFErblaKTICKJNgCex8zgyz51OcZG3k/Ys7Or+xUzTDqm2AOhi
         RXh7MCoa6Vr+NGZQjg7tjkr2cPvrQsaybxNl6HNknB8d05SSHNNWH4jGA66dDOS67P8D
         DE2YGkZLgG6813Cf3PqXHZh2ZvsECE6zjsj0NpL9HPWSFp0fqZXDKXn4t6fG+exlMrCG
         yKHOio0426szrZgIaMbCyYXLHLF7JRhGsVPbOnQ6RFLCDyIcLy60kkyG11V27gV56VN+
         yi0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/OVX1r9Iz0+z3/EtWsPL46cFf+Te6jgc3vVhsdqqxV4=;
        fh=UeV+X8xr+OT3FUo9TFu+ZrFbPLxkxgDV65pQBdOptgI=;
        b=aIRTqMbEBOaTDYYqrE9htGFS/EEuSnZqHD1F6xDEjQTzcfbNbhuSCA0oyDzNTtEUB2
         HD4t6KY0CASUM6GbBkdjGd7g+xmKJUT0j7Sn+n6uNtf/X0kLxU77Euf3NycDXCq3if1V
         uLLIDyk+FSJnUKdlJrSWl+QOoin+4qqqHqeSrOe2m4aBFKZGax1b6HDaRtvjamu6XSwl
         2VuJTr3JWrERb+/SRmICfhtpB6/Xh6WEI2niWVJioOjgS/vhiFChO/fx3xv3iCpbXqkq
         VYlgQcnwX4JMTzMi0XE2i9qTyGiLQRB9uP5xckQcxHp482c5TJbbFsIWQFJ45rwNJVk7
         XO+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774617344; x=1775222144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OVX1r9Iz0+z3/EtWsPL46cFf+Te6jgc3vVhsdqqxV4=;
        b=BLFCwvZRM7sXCHzBbGot3pEzjUDgnT0NDKfX68e8PiYcmlMJVr2jmCCK8rZQTx65X9
         iZLOheGpJ0joN+aKrHCNFzXohxshTr0PxfaCBkZXVecE7Y5pti64x52Vo/vtcI2YDW+Y
         ZK3ao/wBxezzq/6ANKqAFgZ2CdkcDPK+BopmkECl0UjIzPDh1LSenIIdQLF0/lgAECe8
         KkvOyuu9BFqHIT3xK1tAblYNuES8PwBvB4Jp6qk68WgSQPVUcNxBLtIBvdGBr+j0KTOF
         QqSTwyUd1ym56Hk9UIJMp/Poc/oZN80zHiAXXOqt/48yQoSLCalrwKTutpzpR2rZaFQC
         t7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774617344; x=1775222144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/OVX1r9Iz0+z3/EtWsPL46cFf+Te6jgc3vVhsdqqxV4=;
        b=HGlvXZYFqTwZDJLPjrJarweW2Z8+2Vn3wQ0GFrCe0SQjT0eCaRYy2AybElnxPC9j+h
         qjOz8VHDqH3eehgwW96wcVOaMSqQS89zcXeHggcLUEdvIWR1ZsfOTFRo/13ccvUY9Hmf
         /wCUHfqHCd4zi0UsfjZvE4lqxPE34VuKc+KXVba6PWOwweVOJyy5x1EKiM6lf+Z4dRNp
         s0g1//2ASyzsL/XPBzOXXRwY+HrZCS0pyRqniw9xceRavm/TGvXTvOMGJmZbjaWZbRm5
         RrWIsL/pchmQ3/Uvy+BVmnVnWdwQZanbDL13kND1URSdAk198CprYc0rCmJb5JHlnKCL
         SalA==
X-Forwarded-Encrypted: i=1; AJvYcCVvyA3nRAVTHX9mpKbITBMTA/66xnyQNwpwRvoCWdqdLmG3Z2R8jmQHcbDFHrNuQa60E4J5IOFX@vger.kernel.org
X-Gm-Message-State: AOJu0Yzca9IwH/eI4dalXKtn18lEVGOmC6YT3Gx4vqe4/Hz8IFwlLhoY
	WVVQwSFQhMYMoUJFAQ3V21ia229XH5j3MJhfKUO93OCUAiekbwVjWazcDAE48LsXG7aA6rZburd
	GdOmwWeFJL1MNN2KUXjTMoR8/tZbpUl7eUCgiq8a8dfPBZytT1fuvj7STeeY4Y4YHts0GynA+iu
	JYgJG/IwfK5Mz9nAcqrwLMleMBeymgq+LMoQ==
X-Gm-Gg: ATEYQzwGoMofCTNePcjN3eAxRjoKexaD6Yzrs8f4l4pxWrEYOX2/CXNC6hUvasl0pkF
	K+Hmt7n+5DdMl+ztcvgsldSikDa7m18tJ8exgYx71RwDeXQzyue+SMacKUjWLRWPw36gGU/MrLE
	KTb0cRMV+ODQlkz1VbXwVjxBbCV/tzzzkirhlzXBVdLWvsyiU4+FqIRKxi74/VQyQyRIQbXipwd
	5YigQ==
X-Received: by 2002:a05:690e:440c:b0:64e:efc7:b1bf with SMTP id 956f58d0204a3-64ff73cb444mr1504780d50.52.1774617343774;
        Fri, 27 Mar 2026 06:15:43 -0700 (PDT)
X-Received: by 2002:a05:690e:440c:b0:64e:efc7:b1bf with SMTP id
 956f58d0204a3-64ff73cb444mr1504743d50.52.1774617342983; Fri, 27 Mar 2026
 06:15:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327-kunit_cgroups-v1-0-971b3c739a00@redhat.com> <20260327-kunit_cgroups-v1-2-971b3c739a00@redhat.com>
In-Reply-To: <20260327-kunit_cgroups-v1-2-971b3c739a00@redhat.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 27 Mar 2026 14:15:31 +0100
X-Gm-Features: AQROBzCCLothWISj3adq6fH_wHdPhuMARGLGzX96TLnmrtQEQgxz5yaILeRpy2s
Message-ID: <CADSE00LHuHbYF4stJhLrBjTkZRud_qLWzHXk4uLtuXs=NJJSNg@mail.gmail.com>
Subject: Re: [PATCH 2/3] selftests: cgroup: Add dmem selftest coverage
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, mripard@redhat.com, echanude@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15078-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aesteve@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: AE4F3345279
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 9:53=E2=80=AFAM Albert Esteve <aesteve@redhat.com> =
wrote:
>
> Currently, tools/testing/selftests/cgroup/ does not include
> a dmem-specific test binary. This leaves dmem charge and
> limit behavior largely unvalidated in kselftest coverage.
>
> Add test_dmem and wire it into the cgroup selftests Makefile.
> The new test exercises dmem controller behavior through the
> dmem_selftest debugfs interface for the dmem_selftest region.
>
> The test adds three complementary checks:
> - test_dmem_max creates a nested hierarchy with per-leaf
>   dmem.max values and verifies that over-limit charges
>   fail while in-limit charges succeed with bounded rounding
>   in dmem.current.
> - test_dmem_min and test_dmem_low verify that charging
>   from a cgroup with the corresponding protection knob
>   set updates dmem.current as expected.
> - test_dmem_charge_byte_granularity validates accounting
>   bounds for non-page-aligned charge sizes and
>   uncharge-to-zero behavior.
>
> This provides deterministic userspace coverage for dmem
> accounting and hard-limit enforcement using a test helper
> module, without requiring subsystem-specific production
> drivers.
>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  tools/testing/selftests/cgroup/.gitignore  |   1 +
>  tools/testing/selftests/cgroup/Makefile    |   2 +
>  tools/testing/selftests/cgroup/test_dmem.c | 487 +++++++++++++++++++++++=
++++++
>  3 files changed, 490 insertions(+)
>
> diff --git a/tools/testing/selftests/cgroup/.gitignore b/tools/testing/se=
lftests/cgroup/.gitignore
> index 952e4448bf070..ea2322598217d 100644
> --- a/tools/testing/selftests/cgroup/.gitignore
> +++ b/tools/testing/selftests/cgroup/.gitignore
> @@ -2,6 +2,7 @@
>  test_core
>  test_cpu
>  test_cpuset
> +test_dmem
>  test_freezer
>  test_hugetlb_memcg
>  test_kill
> diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/self=
tests/cgroup/Makefile
> index e01584c2189ac..e1a5e9316620e 100644
> --- a/tools/testing/selftests/cgroup/Makefile
> +++ b/tools/testing/selftests/cgroup/Makefile
> @@ -10,6 +10,7 @@ TEST_GEN_FILES :=3D wait_inotify
>  TEST_GEN_PROGS  =3D test_core
>  TEST_GEN_PROGS +=3D test_cpu
>  TEST_GEN_PROGS +=3D test_cpuset
> +TEST_GEN_PROGS +=3D test_dmem
>  TEST_GEN_PROGS +=3D test_freezer
>  TEST_GEN_PROGS +=3D test_hugetlb_memcg
>  TEST_GEN_PROGS +=3D test_kill
> @@ -26,6 +27,7 @@ include lib/libcgroup.mk
>  $(OUTPUT)/test_core: $(LIBCGROUP_O)
>  $(OUTPUT)/test_cpu: $(LIBCGROUP_O)
>  $(OUTPUT)/test_cpuset: $(LIBCGROUP_O)
> +$(OUTPUT)/test_dmem: $(LIBCGROUP_O)
>  $(OUTPUT)/test_freezer: $(LIBCGROUP_O)
>  $(OUTPUT)/test_hugetlb_memcg: $(LIBCGROUP_O)
>  $(OUTPUT)/test_kill: $(LIBCGROUP_O)
> diff --git a/tools/testing/selftests/cgroup/test_dmem.c b/tools/testing/s=
elftests/cgroup/test_dmem.c
> new file mode 100644
> index 0000000000000..cdd5cb7206f16
> --- /dev/null
> +++ b/tools/testing/selftests/cgroup/test_dmem.c
> @@ -0,0 +1,487 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Test the dmem (device memory) cgroup controller.
> + *
> + * Depends on dmem_selftest kernel module.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <linux/limits.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +
> +#include "kselftest.h"
> +#include "cgroup_util.h"
> +
> +/* kernel/cgroup/dmem_selftest.c */
> +#define DM_SELFTEST_REGION     "dmem_selftest"
> +#define DM_SELFTEST_CHARGE     "/sys/kernel/debug/dmem_selftest/charge"
> +#define DM_SELFTEST_UNCHARGE   "/sys/kernel/debug/dmem_selftest/uncharge=
"
> +
> +/*
> + * Parse the first line of dmem.capacity (root):
> + *   "<name> <size_in_bytes>"
> + * Returns 1 if a region was found, 0 if capacity is empty, -1 on read e=
rror.
> + */
> +static int parse_first_region(const char *root, char *name, size_t name_=
len,
> +                             unsigned long long *size_out)
> +{
> +       char buf[4096];
> +       char nm[256];
> +       unsigned long long sz;
> +
> +       if (cg_read(root, "dmem.capacity", buf, sizeof(buf)) < 0)
> +               return -1;
> +
> +       if (sscanf(buf, "%255s %llu", nm, &sz) < 2)
> +               return 0;
> +
> +       if (name_len <=3D strlen(nm))
> +               return -1;
> +
> +       strcpy(name, nm);
> +       *size_out =3D sz;
> +       return 1;
> +}
> +
> +/*
> + * Read the numeric limit for @region_name from a multiline
> + * dmem.{min,low,max} file. Returns bytes,
> + * or -1 if the line is "<name> max", or -2 if missing/err.
> + */
> +static long long dmem_read_limit_for_region(const char *cgroup, const ch=
ar *ctrl,
> +                                           const char *region_name)
> +{
> +       char buf[4096];
> +       char *line, *saveptr =3D NULL;
> +       char fname[256];
> +       char fval[64];
> +
> +       if (cg_read(cgroup, ctrl, buf, sizeof(buf)) < 0)
> +               return -2;
> +
> +       for (line =3D strtok_r(buf, "\n", &saveptr); line;
> +            line =3D strtok_r(NULL, "\n", &saveptr)) {
> +               if (!line[0])
> +                       continue;
> +               if (sscanf(line, "%255s %63s", fname, fval) !=3D 2)
> +                       continue;
> +               if (strcmp(fname, region_name))
> +                       continue;
> +               if (!strcmp(fval, "max"))
> +                       return -1;
> +               return strtoll(fval, NULL, 0);
> +       }
> +       return -2;
> +}
> +
> +static long long dmem_read_limit(const char *cgroup, const char *ctrl)
> +{
> +       return dmem_read_limit_for_region(cgroup, ctrl, DM_SELFTEST_REGIO=
N);
> +}
> +
> +static int dmem_write_limit(const char *cgroup, const char *ctrl,
> +                           const char *val)
> +{
> +       char wr[512];
> +
> +       snprintf(wr, sizeof(wr), "%s %s", DM_SELFTEST_REGION, val);
> +       return cg_write(cgroup, ctrl, wr);
> +}
> +
> +static int dmem_selftest_charge_bytes(unsigned long long bytes)
> +{
> +       char wr[32];
> +
> +       snprintf(wr, sizeof(wr), "%llu", bytes);
> +       return write_text(DM_SELFTEST_CHARGE, wr, strlen(wr));
> +}
> +
> +static int dmem_selftest_uncharge(void)
> +{
> +       return write_text(DM_SELFTEST_UNCHARGE, "\n", 1);
> +}
> +
> +/*
> + * First, this test creates the following hierarchy:
> + * A
> + * A/B     dmem.max=3D1M
> + * A/B/C   dmem.max=3D75K
> + * A/B/D   dmem.max=3D25K
> + * A/B/E   dmem.max=3D8K
> + * A/B/F   dmem.max=3D0
> + *
> + * Then for each leaf cgroup it tries to charge above dmem.max
> + * and expects the charge request to fail and dmem.current to
> + * remain unchanged.
> + *
> + * For leaves with non-zero dmem.max, it additionally charges a
> + * smaller amount and verifies accounting grows within one PAGE_SIZE
> + * rounding bound, then uncharges and verifies dmem.current returns
> + * to the previous value.
> + *
> + */
> +static int test_dmem_max(const char *root)
> +{
> +       static const char * const leaf_max[] =3D { "75K", "25K", "8K", "0=
" };
> +       static const unsigned long long fail_sz[] =3D {
> +               (75ULL * 1024ULL) + 1ULL,
> +               (25ULL * 1024ULL) + 1ULL,
> +               (8ULL * 1024ULL) + 1ULL,
> +               1ULL
> +       };
> +       static const unsigned long long pass_sz[] =3D {
> +               4096ULL, 4096ULL, 4096ULL, 0ULL
> +       };
> +       char *parent[2] =3D {NULL};
> +       char *children[4] =3D {NULL};
> +       unsigned long long cap;
> +       char region[256];
> +       long long page_size;
> +       long long cur_before, cur_after;
> +       int ret =3D KSFT_FAIL;
> +       int charged =3D 0;
> +       int in_child =3D 0;
> +       long long v;
> +       int i;
> +
> +       if (access(DM_SELFTEST_CHARGE, W_OK) !=3D 0)
> +               return KSFT_SKIP;
> +
> +       if (parse_first_region(root, region, sizeof(region), &cap) !=3D 1=
)
> +               return KSFT_SKIP;
> +       if (strcmp(region, DM_SELFTEST_REGION) !=3D 0)
> +               return KSFT_SKIP;
> +
> +       page_size =3D sysconf(_SC_PAGESIZE);
> +       if (page_size <=3D 0)
> +               goto cleanup;
> +
> +       parent[0] =3D cg_name(root, "dmem_prot_0");
> +       parent[1] =3D cg_name(parent[0], "dmem_prot_1");
> +       if (!parent[0] || !parent[1])
> +               goto cleanup;
> +
> +       if (cg_create(parent[0]))
> +               goto cleanup;
> +
> +       if (cg_write(parent[0], "cgroup.subtree_control", "+dmem"))
> +               goto cleanup;
> +
> +       if (cg_create(parent[1]))
> +               goto cleanup;
> +
> +       if (cg_write(parent[1], "cgroup.subtree_control", "+dmem"))
> +               goto cleanup;
> +
> +       for (i =3D 0; i < 4; i++) {
> +               children[i] =3D cg_name_indexed(parent[1], "dmem_child", =
i);
> +               if (!children[i])
> +                       goto cleanup;
> +               if (cg_create(children[i]))
> +                       goto cleanup;
> +       }
> +
> +       if (dmem_write_limit(parent[1], "dmem.max", "1M"))
> +               goto cleanup;
> +       for (i =3D 0; i < 4; i++)
> +               if (dmem_write_limit(children[i], "dmem.max", leaf_max[i]=
))
> +                       goto cleanup;
> +
> +       v =3D dmem_read_limit(parent[1], "dmem.max");
> +       if (!values_close(v, 1024LL * 1024LL, 3))
> +               goto cleanup;
> +       v =3D dmem_read_limit(children[0], "dmem.max");
> +       if (!values_close(v, 75LL * 1024LL, 3))
> +               goto cleanup;
> +       v =3D dmem_read_limit(children[1], "dmem.max");
> +       if (!values_close(v, 25LL * 1024LL, 3))
> +               goto cleanup;
> +       v =3D dmem_read_limit(children[2], "dmem.max");
> +       if (!values_close(v, 8LL * 1024LL, 3))
> +               goto cleanup;
> +       v =3D dmem_read_limit(children[3], "dmem.max");
> +       if (v !=3D 0)
> +               goto cleanup;
> +
> +       for (i =3D 0; i < 4; i++) {
> +               if (cg_enter_current(children[i]))
> +                       goto cleanup;
> +               in_child =3D 1;
> +
> +               cur_before =3D dmem_read_limit(children[i], "dmem.current=
");
> +               if (cur_before < 0)
> +                       goto cleanup;
> +
> +               if (dmem_selftest_charge_bytes(fail_sz[i]) =3D=3D 0)

This should be '>=3D 0', dmem_selftest_charge_bytes() returns the
written bytes on success.

I will fix it in the next iteration.

> +                       goto cleanup;
> +
> +               cur_after =3D dmem_read_limit(children[i], "dmem.current"=
);
> +               if (cur_after !=3D cur_before)
> +                       goto cleanup;
> +
> +               if (pass_sz[i] > 0) {
> +                       if (dmem_selftest_charge_bytes(pass_sz[i]) < 0)
> +                               goto cleanup;
> +                       charged =3D 1;
> +
> +                       cur_after =3D dmem_read_limit(children[i], "dmem.=
current");
> +                       if (cur_after < cur_before + (long long)pass_sz[i=
])
> +                               goto cleanup;
> +                       if (cur_after > cur_before + (long long)pass_sz[i=
] + page_size)
> +                               goto cleanup;
> +
> +                       if (dmem_selftest_uncharge() < 0)
> +                               goto cleanup;
> +                       charged =3D 0;
> +
> +                       cur_after =3D dmem_read_limit(children[i], "dmem.=
current");
> +                       if (cur_after !=3D cur_before)
> +                               goto cleanup;
> +               }
> +
> +               if (cg_enter_current(root))
> +                       goto cleanup;
> +               in_child =3D 0;
> +       }
> +
> +       ret =3D KSFT_PASS;
> +
> +cleanup:
> +       if (charged)
> +               dmem_selftest_uncharge();
> +       if (in_child)
> +               cg_enter_current(root);
> +       for (i =3D 3; i >=3D 0; i--) {
> +               if (!children[i])
> +                       continue;
> +               cg_destroy(children[i]);
> +               free(children[i]);
> +       }
> +       for (i =3D 1; i >=3D 0; i--) {
> +               if (!parent[i])
> +                       continue;
> +               cg_destroy(parent[i]);
> +               free(parent[i]);
> +       }
> +       return ret;
> +}
> +
> +/*
> + * This test sets dmem.min and dmem.low on a child cgroup, then charge
> + * from that context and verify dmem.current tracks the charged bytes
> + * (within one page rounding).
> + */
> +static int test_dmem_charge_with_attr(const char *root, bool min)
> +{
> +       char region[256];
> +       unsigned long long cap;
> +       const unsigned long long charge_sz =3D 12345ULL;
> +       const char *attribute =3D min ? "dmem.min" : "dmem.low";
> +       int ret =3D KSFT_FAIL;
> +       char *cg =3D NULL;
> +       long long cur;
> +       long long page_size;
> +       int charged =3D 0;
> +       int in_child =3D 0;
> +
> +       if (access(DM_SELFTEST_CHARGE, W_OK) !=3D 0)
> +               return KSFT_SKIP;
> +
> +       if (parse_first_region(root, region, sizeof(region), &cap) !=3D 1=
)
> +               return KSFT_SKIP;
> +       if (strcmp(region, DM_SELFTEST_REGION) !=3D 0)
> +               return KSFT_SKIP;
> +
> +       page_size =3D sysconf(_SC_PAGESIZE);
> +       if (page_size <=3D 0)
> +               goto cleanup;
> +
> +       cg =3D cg_name(root, "test_dmem_attr");
> +       if (!cg)
> +               goto cleanup;
> +
> +       if (cg_create(cg))
> +               goto cleanup;
> +
> +       if (cg_enter_current(cg))
> +               goto cleanup;
> +       in_child =3D 1;
> +
> +       if (dmem_write_limit(cg, attribute, "16K"))
> +               goto cleanup;
> +
> +       if (dmem_selftest_charge_bytes(charge_sz) < 0)
> +               goto cleanup;
> +       charged =3D 1;
> +
> +       cur =3D dmem_read_limit(cg, "dmem.current");
> +       if (cur < (long long)charge_sz)
> +               goto cleanup;
> +       if (cur > (long long)charge_sz + page_size)
> +               goto cleanup;
> +
> +       if (dmem_selftest_uncharge() < 0)
> +               goto cleanup;
> +       charged =3D 0;
> +
> +       cur =3D dmem_read_limit(cg, "dmem.current");
> +       if (cur !=3D 0)
> +               goto cleanup;
> +
> +       ret =3D KSFT_PASS;
> +
> +cleanup:
> +       if (charged)
> +               dmem_selftest_uncharge();
> +       if (in_child)
> +               cg_enter_current(root);
> +       cg_destroy(cg);
> +       free(cg);
> +       return ret;
> +}
> +
> +static int test_dmem_min(const char *root)
> +{
> +       return test_dmem_charge_with_attr(root, "dmem.min");
> +}
> +
> +static int test_dmem_low(const char *root)
> +{
> +       return test_dmem_charge_with_attr(root, "dmem.low");
> +}
> +
> +/*
> + * This test charges non-page-aligned byte sizes and verify dmem.current
> + * stays consistent: it must account at least the requested bytes and
> + * never exceed one kernel page of rounding overhead. Then uncharge must
> + * return usage to 0.
> + */
> +static int test_dmem_charge_byte_granularity(const char *root)
> +{
> +       static const unsigned long long sizes[] =3D { 1ULL, 4095ULL, 4097=
ULL, 12345ULL };
> +       char *cg =3D NULL;
> +       unsigned long long cap;
> +       char region[256];
> +       long long cur;
> +       long long page_size;
> +       int ret =3D KSFT_FAIL;
> +       int charged =3D 0;
> +       int in_child =3D 0;
> +       size_t i;
> +
> +       if (access(DM_SELFTEST_CHARGE, W_OK) !=3D 0)
> +               return KSFT_SKIP;
> +
> +       if (parse_first_region(root, region, sizeof(region), &cap) !=3D 1=
)
> +               return KSFT_SKIP;
> +       if (strcmp(region, DM_SELFTEST_REGION) !=3D 0)
> +               return KSFT_SKIP;
> +
> +       page_size =3D sysconf(_SC_PAGESIZE);
> +       if (page_size <=3D 0)
> +               goto cleanup;
> +
> +       cg =3D cg_name(root, "dmem_dbg_byte_gran");
> +       if (!cg)
> +               goto cleanup;
> +
> +       if (cg_create(cg))
> +               goto cleanup;
> +
> +       if (dmem_write_limit(cg, "dmem.max", "8M"))
> +               goto cleanup;
> +
> +       if (cg_enter_current(cg))
> +               goto cleanup;
> +       in_child =3D 1;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(sizes); i++) {
> +               if (dmem_selftest_charge_bytes(sizes[i]) < 0)
> +                       goto cleanup;
> +               charged =3D 1;
> +
> +               cur =3D dmem_read_limit(cg, "dmem.current");
> +               if (cur < (long long)sizes[i])
> +                       goto cleanup;
> +               if (cur > (long long)sizes[i] + page_size)
> +                       goto cleanup;
> +
> +               if (dmem_selftest_uncharge() < 0)
> +                       goto cleanup;
> +               charged =3D 0;
> +
> +               cur =3D dmem_read_limit(cg, "dmem.current");
> +               if (cur !=3D 0)
> +                       goto cleanup;
> +       }
> +
> +       ret =3D KSFT_PASS;
> +
> +cleanup:
> +       if (charged)
> +               dmem_selftest_uncharge();
> +       if (in_child)
> +               cg_enter_current(root);
> +       if (cg) {
> +               cg_destroy(cg);
> +               free(cg);
> +       }
> +       return ret;
> +}
> +
> +#define T(x) { x, #x }
> +struct dmem_test {
> +       int (*fn)(const char *root);
> +       const char *name;
> +} tests[] =3D {
> +       T(test_dmem_max),
> +       T(test_dmem_min),
> +       T(test_dmem_low),
> +       T(test_dmem_charge_byte_granularity),
> +};
> +#undef T
> +
> +int main(int argc, char **argv)
> +{
> +       char root[PATH_MAX];
> +       int i;
> +
> +       ksft_print_header();
> +       ksft_set_plan(ARRAY_SIZE(tests));
> +
> +       if (cg_find_unified_root(root, sizeof(root), NULL))
> +               ksft_exit_skip("cgroup v2 isn't mounted\n");
> +
> +       if (cg_read_strstr(root, "cgroup.controllers", "dmem"))
> +               ksft_exit_skip("dmem controller isn't available (CONFIG_C=
GROUP_DMEM?)\n");
> +
> +       if (cg_read_strstr(root, "cgroup.subtree_control", "dmem"))
> +               if (cg_write(root, "cgroup.subtree_control", "+dmem"))
> +                       ksft_exit_skip("Failed to enable dmem controller\=
n");
> +
> +       for (i =3D 0; i < ARRAY_SIZE(tests); i++) {
> +               switch (tests[i].fn(root)) {
> +               case KSFT_PASS:
> +                       ksft_test_result_pass("%s\n", tests[i].name);
> +                       break;
> +               case KSFT_SKIP:
> +                       ksft_test_result_skip(
> +                               "%s (need CONFIG_DMEM_SELFTEST, modprobe =
dmem_selftest)\n",
> +                               tests[i].name);
> +                       break;
> +               default:
> +                       ksft_test_result_fail("%s\n", tests[i].name);
> +                       break;
> +               }
> +       }
> +
> +       ksft_finished();
> +}
>
> --
> 2.52.0
>


