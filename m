Return-Path: <cgroups+bounces-12251-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B54C9BAC9
	for <lists+cgroups@lfdr.de>; Tue, 02 Dec 2025 14:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F5213A684F
	for <lists+cgroups@lfdr.de>; Tue,  2 Dec 2025 13:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C201A31A7F8;
	Tue,  2 Dec 2025 13:53:21 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5538E20CCE4;
	Tue,  2 Dec 2025 13:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764683601; cv=none; b=h0jW+ES+0NgNUqDQwaR0WB87mRxEPSlvSNswK8GcU4RM/9FJc9hkBdg60/o47E6i4fApz44STPW9BQgtQQfJBujKq56obhOZajM/enLkW2+f2/OwfHsHDCYuBBR9yf/hBQXUkWj/z87sSAQoE7/6lWVjTOmNWH5NAdhgIiWbYGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764683601; c=relaxed/simple;
	bh=vUUtBOj3ZT2eiMzIDwv6k7nd1a6UFcBxI3Rb2mee4d8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HhRX07LwsfRB47lADxtdnSoY3xf+Mw6TjsRp1715EUOhr/x5PeKsMODp1I8RnwdtUbtRBddSck+Xo5k/LINk4vA24hmCzXV80Gh9oYEEPIPyU9FzCD+CjjTYQ5qjVKKHbwqQmRETMndv71ay3dqaNdQsRJRQSmd+O+8WJLJX4Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dLMf06XLyzKHMVb;
	Tue,  2 Dec 2025 21:52:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D47231A0B7C;
	Tue,  2 Dec 2025 21:53:12 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgB3n5xH7y5psS9oAQ--.22172S2;
	Tue, 02 Dec 2025 21:53:12 +0800 (CST)
Message-ID: <e5b53c3a-563a-4af6-94e6-1ce4acc7b399@huaweicloud.com>
Date: Tue, 2 Dec 2025 21:53:11 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup: Use descriptor table to unify mount flag
 management
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, lujialin4@huawei.com, chenridong@huawei.com
References: <20251126020825.1511671-1-chenridong@huaweicloud.com>
 <nz6urfhwkgigftrovogbwzeqnrsnrnslmxcvpere7bv2im4uho@mdfhkvmpret4>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <nz6urfhwkgigftrovogbwzeqnrsnrnslmxcvpere7bv2im4uho@mdfhkvmpret4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3n5xH7y5psS9oAQ--.22172S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw1DAr4DXrWUCrWUJw48Crg_yoW7CF1kpF
	Z3Gas0kwn3JF9xu348tayFqr4ruw4rXr42yFy5AryFkwsrJr12qF4Ika1UZF1YqFn3Jw12
	vFs0vw15Ga1ak3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/12/2 17:24, Michal Koutný wrote:
> Hi Ridong.
> 
> On Wed, Nov 26, 2025 at 02:08:25AM +0000, Chen Ridong <chenridong@huaweicloud.com> wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> The cgroup2 mount flags (e.g. nsdelegate, favordynmods) were previously
>> handled via scattered switch-case and conditional checks across
>> parameter parsing, flag application, and option display paths. This
>> leads to redundant code and increased maintenance cost when adding/removing
>> flags.
>>
>> Introduce a `cgroup_mount_flag_desc` descriptor table to centralize the
>> mapping between flag bits, names, and apply functions. Refactor the
>> relevant paths to use this table for unified management:
>> 1. cgroup2_parse_param: Replace switch-case with table lookup
>> 2. apply_cgroup_root_flags: Replace multiple conditionals with table
>>    iteration
>> 3. cgroup_show_options: Replace hardcoded seq_puts with table-driven output
>>
>> No functional change intended, and the mount option output format remains
>> compatible with the original implementation.
> 
> At first I thought this is worthy but then I ran into the possible
> (semantic) overlap with the cgroup2_fs_parameters array (the string
> `name`s are duplicated in both :-/), I didn't figure out a way how to
> make such an polymorphic array in C (like when cgroup_mount_flag_desc
> would be a class that inherits from fs_parameter_spec and you could pass
> the array of the formers to consumers (fs_parse()) of latters).
> 
> So I'm wondering whether there exists some way to avoid possible
> divergence between definitions of the two arrays...
> 

Hi Michal,

Thank you for your thoughtful feedback.

I understand your concern about the semantic overlap between the two arrays and the potential for
divergence. I initially tried to find a way to merge them into a single polymorphic array, but given
the constraints of C and the existing fs_parameter_spec structure (which we cannot easily modify for
this purpose), I haven't found a clean way to achieve that.

However, to address the maintenance issue, I've come up with an alternative approach using a macro
that allows us to define mount flags in just one place. The idea is to introduce a macro list
CGROUP2_MOUNT_FLAG_LIST that expands into both the fs_parameter_spec array and the new
cgroup_mount_flag_desc table. This way, when adding a new mount flag, we only need to extend this
single macro list.

While we still end up with two separate arrays, the macro ensures that any addition or modification
only needs to be made in one place—the CGROUP2_MOUNT_FLAG_LIST. This should prevent the divergence
you mentioned.

What do you think about this approach? If you have any suggestions for further improvement, I'd be
happy to incorporate them.

Below is a simplified diff showing the concept:

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index e717208cfb18..bd81b15dc3bd 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1985,26 +1985,53 @@ int cgroup_show_path(struct seq_file *sf, struct kernfs_node *kf_node,
 	return len;
 }

+#define CGROUP2_MOUNT_FLAG_LIST(_)					\
+	_(nsdelegate,		CGRP_ROOT_NS_DELEGATE,	apply_cgroup_root_flag) \
+	_(favordynmods,	CGRP_ROOT_FAVOR_DYNMODS,	apply_cgroup_favor_flag) \
+	_(memory_localevents,	CGRP_ROOT_MEMORY_LOCAL_EVENTS, apply_cgroup_root_flag) \
+	_(memory_recursiveprot,	CGRP_ROOT_MEMORY_RECURSIVE_PROT, apply_cgroup_root_flag) \
+	_(memory_hugetlb_accounting, CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING, apply_cgroup_root_flag) \
+	_(pids_localevents,	CGRP_ROOT_PIDS_LOCAL_EVENTS, apply_cgroup_root_flag)
+
 enum cgroup2_param {
-	Opt_nsdelegate,
-	Opt_favordynmods,
-	Opt_memory_localevents,
-	Opt_memory_recursiveprot,
-	Opt_memory_hugetlb_accounting,
-	Opt_pids_localevents,
+#define CGROUP2_PARAM_ENUM(name, ...) Opt_##name,
+	CGROUP2_MOUNT_FLAG_LIST(CGROUP2_PARAM_ENUM)
+#undef CGROUP2_PARAM_ENUM
 	nr__cgroup2_params
 };

+struct cgroup_mount_flag_desc {
+	enum cgroup_root_flag flag;
+	const char *name;
+	void (*apply)(enum cgroup_root_flag flag, bool enable);
+};
+
+static void apply_cgroup_root_flag(enum cgroup_root_flag flag, bool enable)
+{
+	if (enable)
+		cgrp_dfl_root.flags |= flag;
+	else
+		cgrp_dfl_root.flags &= ~flag;
+}
+
+static void apply_cgroup_favor_flag(enum cgroup_root_flag flag, bool enable)
+{
+	cgroup_favor_dynmods(&cgrp_dfl_root, enable);
+}
+
 static const struct fs_parameter_spec cgroup2_fs_parameters[] = {
-	fsparam_flag("nsdelegate",		Opt_nsdelegate),
-	fsparam_flag("favordynmods",		Opt_favordynmods),
-	fsparam_flag("memory_localevents",	Opt_memory_localevents),
-	fsparam_flag("memory_recursiveprot",	Opt_memory_recursiveprot),
-	fsparam_flag("memory_hugetlb_accounting", Opt_memory_hugetlb_accounting),
-	fsparam_flag("pids_localevents",	Opt_pids_localevents),
+#define CGROUP2_PARAM_SPEC(name, ...) fsparam_flag(#name, Opt_##name),
+	CGROUP2_MOUNT_FLAG_LIST(CGROUP2_PARAM_SPEC)
+#undef CGROUP2_PARAM_SPEC
 	{}
 };

+static const struct cgroup_mount_flag_desc cgroup2_mount_flags[] = {
+#define CGROUP2_FLAG_DESC(name, flag, apply)[Opt_##name] = { flag, #name, apply },
+	CGROUP2_MOUNT_FLAG_LIST(CGROUP2_FLAG_DESC)
+#undef CGROUP2_FLAG_DESC
+};
+
...

-- 
Best regards,
Ridong


