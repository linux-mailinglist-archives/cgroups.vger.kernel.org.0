Return-Path: <cgroups+bounces-3296-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEAF9140B5
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2024 04:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 769F61F2393B
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2024 02:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F8C53A7;
	Mon, 24 Jun 2024 02:59:23 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E116FB0;
	Mon, 24 Jun 2024 02:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719197963; cv=none; b=Drs0jX+QIad94CvrBiU4vBifY2VkMnXQYMZQEXGfvfMuDMOuxDtDyOClfHH8txafmJRstIJqaX7FcZOchAOmH+yeceniS49qDq6IsB9y+WY+BekbxepJBXblO33EHggLEM0s6MQWBYOSdREe0navdP3zjtqk7RfrXyRJBx5uMzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719197963; c=relaxed/simple;
	bh=IRibUyIrLzpKWBF15o5JRcoeIovf2xlYNBijzj3HH7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=J4SlkFU7AxT9qnD522PI3Bd2cecYeNNypHyrIcTG0A7REJ8aYkRntb9N7Ua9rG0vQa1rI/6X7tilpDcB5UcG4n70i8zoC1Oo+oACMm7ZOJ0T79QOtL0UeB3IbYt6WiSw7cjNWTXNkgqRvBPM7k/WUrJOyufSvF6ivaLls4GwNzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W6t1N5M5lzddQ2;
	Mon, 24 Jun 2024 10:57:44 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 8B887141112;
	Mon, 24 Jun 2024 10:59:17 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Mon, 24 Jun
 2024 10:59:17 +0800
Message-ID: <52f72d1d-602e-4dca-85a3-adade925b056@huawei.com>
Date: Mon, 24 Jun 2024 10:59:16 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup: fix uaf when proc_cpuset_show
To: Waiman Long <longman@redhat.com>, <tj@kernel.org>,
	<lizefan.x@bytedance.com>, <hannes@cmpxchg.org>
CC: <bpf@vger.kernel.org>, <cgroups@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240622113814.120907-1-chenridong@huawei.com>
 <19648b9c-6df7-45cd-a5ae-624a3e4d860f@redhat.com>
Content-Language: en-US
From: chenridong <chenridong@huawei.com>
In-Reply-To: <19648b9c-6df7-45cd-a5ae-624a3e4d860f@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd100013.china.huawei.com (7.221.188.163)


On 2024/6/22 23:05, Waiman Long wrote:
>
> On 6/22/24 07:38, Chen Ridong wrote:
>> We found a refcount UAF bug as follows:
>>
>> BUG: KASAN: use-after-free in cgroup_path_ns+0x112/0x150
>> Read of size 8 at addr ffff8882a4b242b8 by task atop/19903
>>
>> CPU: 27 PID: 19903 Comm: atop Kdump: loaded Tainted: GF
>> Call Trace:
>>   dump_stack+0x7d/0xa7
>>   print_address_description.constprop.0+0x19/0x170
>>   ? cgroup_path_ns+0x112/0x150
>>   __kasan_report.cold+0x6c/0x84
>>   ? print_unreferenced+0x390/0x3b0
>>   ? cgroup_path_ns+0x112/0x150
>>   kasan_report+0x3a/0x50
>>   cgroup_path_ns+0x112/0x150
>>   proc_cpuset_show+0x164/0x530
>>   proc_single_show+0x10f/0x1c0
>>   seq_read_iter+0x405/0x1020
>>   ? aa_path_link+0x2e0/0x2e0
>>   seq_read+0x324/0x500
>>   ? seq_read_iter+0x1020/0x1020
>>   ? common_file_perm+0x2a1/0x4a0
>>   ? fsnotify_unmount_inodes+0x380/0x380
>>   ? bpf_lsm_file_permission_wrapper+0xa/0x30
>>   ? security_file_permission+0x53/0x460
>>   vfs_read+0x122/0x420
>>   ksys_read+0xed/0x1c0
>>   ? __ia32_sys_pwrite64+0x1e0/0x1e0
>>   ? __audit_syscall_exit+0x741/0xa70
>>   do_syscall_64+0x33/0x40
>>   entry_SYSCALL_64_after_hwframe+0x67/0xcc
>>
>> This is also reported by: 
>> https://syzkaller.appspot.com/bug?extid=9b1ff7be974a403aa4cd
>>
>> This can be reproduced by the following methods:
>> 1.add an mdelay(1000) before acquiring the cgroup_lock In the
>>   cgroup_path_ns function.
>> 2.$cat /proc/<pid>/cpuset   repeatly.
>> 3.$mount -t cgroup -o cpuset cpuset /sys/fs/cgroup/cpuset/
>> $umount /sys/fs/cgroup/cpuset/   repeatly.
>>
>> The race that cause this bug can be shown as below:
>>
>> (umount)        |    (cat /proc/<pid>/cpuset)
>> css_release        |    proc_cpuset_show
>> css_release_work_fn    |    css = task_get_css(tsk, cpuset_cgrp_id);
>> css_free_rwork_fn    |    cgroup_path_ns(css->cgroup, ...);
>> cgroup_destroy_root    |    mutex_lock(&cgroup_mutex);
>> rebind_subsystems    |
>> cgroup_free_root     |
>>             |    // cgrp was freed, UAF
>>             |    cgroup_path_ns_locked(cgrp,..);
>>
>> When the cpuset is initialized, the root node top_cpuset.css.cgrp
>> will point to &cgrp_dfl_root.cgrp. In cgroup v1, the mount operation 
>> will
>> allocate cgroup_root, and top_cpuset.css.cgrp will point to the 
>> allocated
>> &cgroup_root.cgrp. When the umount operation is executed,
>> top_cpuset.css.cgrp will be rebound to &cgrp_dfl_root.cgrp.
>>
>> The problem is that when rebinding to cgrp_dfl_root, there are cases
>> where the cgroup_root allocated by setting up the root for cgroup v1
>> is cached. This could lead to a Use-After-Free (UAF) if it is
>> subsequently freed. The descendant cgroups of cgroup v1 can only be
>> freed after the css is released. However, the css of the root will never
>> be released, yet the cgroup_root should be freed when it is unmounted.
>> This means that obtaining a reference to the css of the root does
>> not guarantee that css.cgrp->root will not be freed.
>>
>> To solve this issue, we have added a cgroup reference count in
>> the proc_cpuset_show function to ensure that css.cgrp->root will not
>> be freed prematurely. This is a temporary solution. Let's see if anyone
>> has a better solution.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index c12b9fdb22a4..782eaf807173 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -5045,6 +5045,7 @@ int proc_cpuset_show(struct seq_file *m, struct 
>> pid_namespace *ns,
>>       char *buf;
>>       struct cgroup_subsys_state *css;
>>       int retval;
>> +    struct cgroup *root_cgroup = NULL;
>>         retval = -ENOMEM;
>>       buf = kmalloc(PATH_MAX, GFP_KERNEL);
>> @@ -5052,9 +5053,28 @@ int proc_cpuset_show(struct seq_file *m, 
>> struct pid_namespace *ns,
>>           goto out;
>>         css = task_get_css(tsk, cpuset_cgrp_id);
>> +    rcu_read_lock();
>> +    /*
>> +     * When the cpuset subsystem is mounted on the legacy hierarchy,
>> +     * the top_cpuset.css->cgroup does not hold a reference count of
>> +     * cgroup_root.cgroup. This makes accessing css->cgroup very
>> +     * dangerous because when the cpuset subsystem is remounted to the
>> +     * default hierarchy, the cgroup_root.cgroup that css->cgroup 
>> points
>> +     * to will be released, leading to a UAF issue. To avoid this 
>> problem,
>> +     * get the reference count of top_cpuset.css->cgroup first.
>> +     *
>> +     * This is ugly!!
>> +     */
>> +    if (css == &top_cpuset.css) {
>> +        cgroup_get(css->cgroup);
>> +        root_cgroup = css->cgroup;
>> +    }
>> +    rcu_read_unlock();
>>       retval = cgroup_path_ns(css->cgroup, buf, PATH_MAX,
>>                   current->nsproxy->cgroup_ns);
>>       css_put(css);
>> +    if (root_cgroup)
>> +        cgroup_put(root_cgroup);
>>       if (retval == -E2BIG)
>>           retval = -ENAMETOOLONG;
>>       if (retval < 0)
>
> Thanks for reporting this UAF bug. Could you try the attached patch to 
> see if it can fix the issue?
>

+/*
+ * With a cgroup v1 mount, root_css.cgroup can be freed. We need to take a
+ * reference to it to avoid UAF as proc_cpuset_show() may access the 
content
+ * of this cgroup.
+ */
  static void cpuset_bind(struct cgroup_subsys_state *root_css)
  {
+    static struct cgroup *v1_cgroup_root;
+
      mutex_lock(&cpuset_mutex);
+    if (v1_cgroup_root) {
+        cgroup_put(v1_cgroup_root);
+        v1_cgroup_root = NULL;
+    }
      spin_lock_irq(&callback_lock);

      if (is_in_v2_mode()) {
@@ -4159,6 +4170,10 @@ static void cpuset_bind(struct 
cgroup_subsys_state *root_css)
      }

      spin_unlock_irq(&callback_lock);
+    if (!cgroup_subsys_on_dfl(cpuset_cgrp_subsys)) {
+        v1_cgroup_root = root_css->cgroup;
+        cgroup_get(v1_cgroup_root);
+    }
      mutex_unlock(&cpuset_mutex);
  }

Thanks for your suggestion. If we take a reference at rebind(call 
->bind()) function, cgroup_root allocated when setting up root for 
cgroup v1 can never be released, because the reference count will never 
be reduced to zero.

We have already tried similar methods to fix this issue, however doing 
so causes another issue as mentioned previously.


Ridong


