Return-Path: <cgroups+bounces-11287-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2788C1617A
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 18:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2BB1B27399
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 17:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BD534A766;
	Tue, 28 Oct 2025 17:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bETZ7msn"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12F134321B;
	Tue, 28 Oct 2025 17:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761671608; cv=none; b=SCifFLCj/z/Mz0B4/HcUIEiAqrApA12q7CkNbLlexkyieYjy1WakMCBhslxIgLyUegv65IKXEQtwYeBKgIxasFX1QDorHO4rIRweO/b0gFDop/qahJogvxRIepUER3KiUSXm3NqnRZieq9KVZlT5xSXhNGg6kNeXpZD55wGRhWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761671608; c=relaxed/simple;
	bh=oF0hCcRpnf8Y0H9jHAyvalV2EPZtLQD4NJ/eivE3/p0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NT1i6nF4nGWgFC2RrbAXYFk7Wh05g4YRXa8LrMg2CbyQAc2BZ0d4hIW7iYqwnlf9NL0lMz3sn04A56qiMX+kJQ3MZzwSdgX1wyMWw21NCa+VlaRyMVuV4lDjrAh0lP/IQ9+GULXbapgmA2TjpEZ4FfJJe4ASr9PQYJVEOWMR7B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bETZ7msn; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761671605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nJHlxyWxpDIMG0ImD4DSen3qTXT0kex5+xGl06qdYJQ=;
	b=bETZ7msn3crSVDtk07snSuCaX4ndFvUlInJPywBUoH+JIAJhjbKmUSZJIqg2qqdHjuvlDo
	zoqTeXodQ4w+M6M/xBvrQB8AkZwUFlYk8+OLNV0DWxbLUJX70grRsKw+15OC/oNxfNXGmr
	dN/DtW3MiI+c4hlgK+6JpFFbM9WMePA=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: bot+bpf-ci@kernel.org
Cc: akpm@linux-foundation.org,  linux-kernel@vger.kernel.org,
 ast@kernel.org, surenb@google.com, mhocko@kernel.org,
 shakeel.butt@linux.dev, hannes@cmpxchg.org, andrii@kernel.org,
 inwardvessel@gmail.com, linux-mm@kvack.org, cgroups@vger.kernel.org,
 bpf@vger.kernel.org, martin.lau@kernel.org, song@kernel.org,
 memxor@gmail.com, tj@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
 yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH v2 23/23] bpf: selftests: PSI struct ops test
In-Reply-To: <ab8c7bf2f312e150c22d83e5ebe91e17f3c4be42b3ff0825623caf3aac4086af@mail.kernel.org>
	(bot's message of "Mon, 27 Oct 2025 23:48:28 +0000 (UTC)")
References: <20251027232206.473085-13-roman.gushchin@linux.dev>
	<ab8c7bf2f312e150c22d83e5ebe91e17f3c4be42b3ff0825623caf3aac4086af@mail.kernel.org>
Date: Tue, 28 Oct 2025 10:13:10 -0700
Message-ID: <87ikfzuezd.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

bot+bpf-ci@kernel.org writes:

> ```
> commit 70a4d534559f5708a811241190cd158e83451a42
> Author: Roman Gushchin <roman.gushchin@linux.dev>
>
> bpf: selftests: PSI struct ops test
>
> This patch adds a BPF selftest for PSI struct ops functionality,
> including cgroup lifecycle callbacks, PSI trigger creation, and
> memory pressure event handling.
>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/test_psi.c b/tools/testing/selftests/bpf/prog_tests/test_psi.c
>> new file mode 100644
>> index 000000000..b294cea0a
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/test_psi.c
>
> [ ... ]
>
>> diff --git a/tools/testing/selftests/bpf/progs/test_psi.c b/tools/testing/selftests/bpf/progs/test_psi.c
>> new file mode 100644
>> index 000000000..4ddec7ec3
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/test_psi.c
>> @@ -0,0 +1,82 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +#include "vmlinux.h"
>> +#include <bpf/bpf_helpers.h>
>> +#include <bpf/bpf_tracing.h>
>> +
>> +char _license[] SEC("license") = "GPL";
>> +
>> +#define PSI_FULL 0x80000000
>> +
>> +/* cgroup which will experience the high memory pressure */
>> +u64 high_pressure_cgroup_id;
>> +
>> +/* cgroup which will be deleted */
>> +u64 deleted_cgroup_id;
>> +
>> +/* cgroup which will be created */
>> +u64 new_cgroup_id;
>> +
>> +/* cgroup which was deleted */
>> +u64 deleted_cgroup_id;
>>    ^^^^^^^^^^^^^^^^^^
>
> Is deleted_cgroup_id intentionally declared twice here? This appears
> to be a duplicate global variable declaration - the same variable is
> declared at line 13 with comment "cgroup which will be deleted" and
> again at line 19 with comment "cgroup which was deleted".

Correct, fixed.

Thanks!

