Return-Path: <cgroups+bounces-3319-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A27915ACB
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 01:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69870282050
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2024 23:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60F51A2C23;
	Mon, 24 Jun 2024 23:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ONmjeTCf"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA3A1A2576
	for <cgroups@vger.kernel.org>; Mon, 24 Jun 2024 23:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719273567; cv=none; b=tn/qIj2YR4csXtHZDURN2n/ArcsrJeJsY2df+iOgSoSbWba8xzaNjyJmRxl2eFinb8Eu2CjgrzdeeUYXEBuwkkmkE2QZejPk74EwfeD3n1L3PmyhsPUshQME+lzcdZQXbeooLg7x9pdcl0snByhrSvvUDtF+kppv3sRI87YYcoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719273567; c=relaxed/simple;
	bh=n71HNSuDaWlLrCQVM594B5x/oTU5MOMjzbxlvKwnAks=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=H7scvZRCqQYtLXvjrki6O50RnDtmiqdqqMoKpnnmTgBxpzFjUvCsBg27ZdZhLsG4G+1DrxHks3M4U9ChB6AC9/Vnhzzeg7oL8Mfch8G9udbuIUdMMVPlZzlb8C2Wo7sHxxNp08hf6iZyQfilei1XTTNsQbB59GbR/Mhdrlit+3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ONmjeTCf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719273564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZzzF3xgOlJsRKpnG5UrvoUqQA4GXLlIqGHYQP2s+KYg=;
	b=ONmjeTCffPK0Nx0nWr2esL2HYCBQHI37A8xEhIDAmqQFtShgfVLfjRJzF5dfkUDhxfp8N1
	xD0xhv36h/Lp+/DZ/WC+z09m7mW7PITN2WEAC/U2Tpy8hOGvxXqjThob4/p00qpre1iUcX
	cA76Zo5klonjrCwf4nWz0vuggscDiGw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-392-GbyAzQmrOPa3PUkE5n5Qdw-1; Mon,
 24 Jun 2024 19:59:20 -0400
X-MC-Unique: GbyAzQmrOPa3PUkE5n5Qdw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B06A419560B0;
	Mon, 24 Jun 2024 23:59:18 +0000 (UTC)
Received: from [10.22.17.135] (unknown [10.22.17.135])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C6F3A19560AE;
	Mon, 24 Jun 2024 23:59:16 +0000 (UTC)
Content-Type: multipart/mixed; boundary="------------zYFHqbA6TwbLQ80GIyHAX7jS"
Message-ID: <71a9cc3a-1b58-4051-984b-dd4f18dabf84@redhat.com>
Date: Mon, 24 Jun 2024 19:59:15 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup: fix uaf when proc_cpuset_show
To: chenridong <chenridong@huawei.com>, tj@kernel.org,
 lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc: bpf@vger.kernel.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240622113814.120907-1-chenridong@huawei.com>
 <19648b9c-6df7-45cd-a5ae-624a3e4d860f@redhat.com>
 <52f72d1d-602e-4dca-85a3-adade925b056@huawei.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <52f72d1d-602e-4dca-85a3-adade925b056@huawei.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

This is a multi-part message in MIME format.
--------------zYFHqbA6TwbLQ80GIyHAX7jS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/23/24 22:59, chenridong wrote:
>
> On 2024/6/22 23:05, Waiman Long wrote:
>>
>> On 6/22/24 07:38, Chen Ridong wrote:
>>> We found a refcount UAF bug as follows:
>>>
>>> BUG: KASAN: use-after-free in cgroup_path_ns+0x112/0x150
>>> Read of size 8 at addr ffff8882a4b242b8 by task atop/19903
>>>
>>> CPU: 27 PID: 19903 Comm: atop Kdump: loaded Tainted: GF
>>> Call Trace:
>>>   dump_stack+0x7d/0xa7
>>>   print_address_description.constprop.0+0x19/0x170
>>>   ? cgroup_path_ns+0x112/0x150
>>>   __kasan_report.cold+0x6c/0x84
>>>   ? print_unreferenced+0x390/0x3b0
>>>   ? cgroup_path_ns+0x112/0x150
>>>   kasan_report+0x3a/0x50
>>>   cgroup_path_ns+0x112/0x150
>>>   proc_cpuset_show+0x164/0x530
>>>   proc_single_show+0x10f/0x1c0
>>>   seq_read_iter+0x405/0x1020
>>>   ? aa_path_link+0x2e0/0x2e0
>>>   seq_read+0x324/0x500
>>>   ? seq_read_iter+0x1020/0x1020
>>>   ? common_file_perm+0x2a1/0x4a0
>>>   ? fsnotify_unmount_inodes+0x380/0x380
>>>   ? bpf_lsm_file_permission_wrapper+0xa/0x30
>>>   ? security_file_permission+0x53/0x460
>>>   vfs_read+0x122/0x420
>>>   ksys_read+0xed/0x1c0
>>>   ? __ia32_sys_pwrite64+0x1e0/0x1e0
>>>   ? __audit_syscall_exit+0x741/0xa70
>>>   do_syscall_64+0x33/0x40
>>>   entry_SYSCALL_64_after_hwframe+0x67/0xcc
>>>
>>> This is also reported by: 
>>> https://syzkaller.appspot.com/bug?extid=9b1ff7be974a403aa4cd
>>>
>>> This can be reproduced by the following methods:
>>> 1.add an mdelay(1000) before acquiring the cgroup_lock In the
>>>   cgroup_path_ns function.
>>> 2.$cat /proc/<pid>/cpuset   repeatly.
>>> 3.$mount -t cgroup -o cpuset cpuset /sys/fs/cgroup/cpuset/
>>> $umount /sys/fs/cgroup/cpuset/   repeatly.
>>>
>>> The race that cause this bug can be shown as below:
>>>
>>> (umount)        |    (cat /proc/<pid>/cpuset)
>>> css_release        |    proc_cpuset_show
>>> css_release_work_fn    |    css = task_get_css(tsk, cpuset_cgrp_id);
>>> css_free_rwork_fn    |    cgroup_path_ns(css->cgroup, ...);
>>> cgroup_destroy_root    |    mutex_lock(&cgroup_mutex);
>>> rebind_subsystems    |
>>> cgroup_free_root     |
>>>             |    // cgrp was freed, UAF
>>>             |    cgroup_path_ns_locked(cgrp,..);
>>>
>>> When the cpuset is initialized, the root node top_cpuset.css.cgrp
>>> will point to &cgrp_dfl_root.cgrp. In cgroup v1, the mount operation 
>>> will
>>> allocate cgroup_root, and top_cpuset.css.cgrp will point to the 
>>> allocated
>>> &cgroup_root.cgrp. When the umount operation is executed,
>>> top_cpuset.css.cgrp will be rebound to &cgrp_dfl_root.cgrp.
>>>
>>> The problem is that when rebinding to cgrp_dfl_root, there are cases
>>> where the cgroup_root allocated by setting up the root for cgroup v1
>>> is cached. This could lead to a Use-After-Free (UAF) if it is
>>> subsequently freed. The descendant cgroups of cgroup v1 can only be
>>> freed after the css is released. However, the css of the root will 
>>> never
>>> be released, yet the cgroup_root should be freed when it is unmounted.
>>> This means that obtaining a reference to the css of the root does
>>> not guarantee that css.cgrp->root will not be freed.
>>>
>>> To solve this issue, we have added a cgroup reference count in
>>> the proc_cpuset_show function to ensure that css.cgrp->root will not
>>> be freed prematurely. This is a temporary solution. Let's see if anyone
>>> has a better solution.
>>>
>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>> ---
>>>   kernel/cgroup/cpuset.c | 20 ++++++++++++++++++++
>>>   1 file changed, 20 insertions(+)
>>>
>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>> index c12b9fdb22a4..782eaf807173 100644
>>> --- a/kernel/cgroup/cpuset.c
>>> +++ b/kernel/cgroup/cpuset.c
>>> @@ -5045,6 +5045,7 @@ int proc_cpuset_show(struct seq_file *m, 
>>> struct pid_namespace *ns,
>>>       char *buf;
>>>       struct cgroup_subsys_state *css;
>>>       int retval;
>>> +    struct cgroup *root_cgroup = NULL;
>>>         retval = -ENOMEM;
>>>       buf = kmalloc(PATH_MAX, GFP_KERNEL);
>>> @@ -5052,9 +5053,28 @@ int proc_cpuset_show(struct seq_file *m, 
>>> struct pid_namespace *ns,
>>>           goto out;
>>>         css = task_get_css(tsk, cpuset_cgrp_id);
>>> +    rcu_read_lock();
>>> +    /*
>>> +     * When the cpuset subsystem is mounted on the legacy hierarchy,
>>> +     * the top_cpuset.css->cgroup does not hold a reference count of
>>> +     * cgroup_root.cgroup. This makes accessing css->cgroup very
>>> +     * dangerous because when the cpuset subsystem is remounted to the
>>> +     * default hierarchy, the cgroup_root.cgroup that css->cgroup 
>>> points
>>> +     * to will be released, leading to a UAF issue. To avoid this 
>>> problem,
>>> +     * get the reference count of top_cpuset.css->cgroup first.
>>> +     *
>>> +     * This is ugly!!
>>> +     */
>>> +    if (css == &top_cpuset.css) {
>>> +        cgroup_get(css->cgroup);
>>> +        root_cgroup = css->cgroup;
>>> +    }
>>> +    rcu_read_unlock();
>>>       retval = cgroup_path_ns(css->cgroup, buf, PATH_MAX,
>>>                   current->nsproxy->cgroup_ns);
>>>       css_put(css);
>>> +    if (root_cgroup)
>>> +        cgroup_put(root_cgroup);
>>>       if (retval == -E2BIG)
>>>           retval = -ENAMETOOLONG;
>>>       if (retval < 0)
>>
>> Thanks for reporting this UAF bug. Could you try the attached patch 
>> to see if it can fix the issue?
>>
>
> +/*
> + * With a cgroup v1 mount, root_css.cgroup can be freed. We need to 
> take a
> + * reference to it to avoid UAF as proc_cpuset_show() may access the 
> content
> + * of this cgroup.
> + */
>  static void cpuset_bind(struct cgroup_subsys_state *root_css)
>  {
> +    static struct cgroup *v1_cgroup_root;
> +
>      mutex_lock(&cpuset_mutex);
> +    if (v1_cgroup_root) {
> +        cgroup_put(v1_cgroup_root);
> +        v1_cgroup_root = NULL;
> +    }
>      spin_lock_irq(&callback_lock);
>
>      if (is_in_v2_mode()) {
> @@ -4159,6 +4170,10 @@ static void cpuset_bind(struct 
> cgroup_subsys_state *root_css)
>      }
>
>      spin_unlock_irq(&callback_lock);
> +    if (!cgroup_subsys_on_dfl(cpuset_cgrp_subsys)) {
> +        v1_cgroup_root = root_css->cgroup;
> +        cgroup_get(v1_cgroup_root);
> +    }
>      mutex_unlock(&cpuset_mutex);
>  }
>
> Thanks for your suggestion. If we take a reference at rebind(call 
> ->bind()) function, cgroup_root allocated when setting up root for 
> cgroup v1 can never be released, because the reference count will 
> never be reduced to zero.
>
> We have already tried similar methods to fix this issue, however doing 
> so causes another issue as mentioned previously.

You are right. Taking the reference in cpuset_bind() will prevent 
cgroup_destroy_root() from being called. I had overlooked that.

Now I have an even simpler fix. Could you try the attached v2 patch to 
verify if that can fix the problem?

Thanks,
Longman

--------------zYFHqbA6TwbLQ80GIyHAX7jS
Content-Type: text/x-patch; charset=UTF-8;
 name="v2-0001-cgroup-cpuset-Prevent-UAF-in-proc_cpuset_show.patch"
Content-Disposition: attachment;
 filename*0="v2-0001-cgroup-cpuset-Prevent-UAF-in-proc_cpuset_show.patch"
Content-Transfer-Encoding: base64

RnJvbSAyOTk2MjM1NTQ1NDMzY2UyNWU5MTdhZjExZjQ5ODVkN2I2ODgwNzY0IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBXYWltYW4gTG9uZyA8bG9uZ21hbkByZWRoYXQuY29t
PgpEYXRlOiBNb24sIDI0IEp1biAyMDI0IDE5OjUzOjMyIC0wNDAwClN1YmplY3Q6IFtQQVRD
SCB2Ml0gY2dyb3VwL2NwdXNldDogUHJldmVudCBVQUYgaW4gcHJvY19jcHVzZXRfc2hvdygp
CgpUaGUgdW5tb3VudGluZyBvZiBhIGNwdXNldCBjZ3JvdXAgZmlsZXN5c3RlbSB3aWxsIGxl
YWQgdG8gYSBjYWxsIHRvCmNwdXNldF9iaW5kKCkgdG8gcmViaW5kIGl0IGJhY2sgdG8gJmNn
cnBfZGZsX3Jvb3QuY2dycCB2aWEgdGhlIGZvbGxvd2luZwpjYWxsIHNlcXVlbmNlLgoKICBj
Z3JvdXBfZGVzdHJveV9yb290KCkKICAtLT4gcmViaW5kX3N1YnN5c3RlbXMoKQogIC0tPiBj
cHVzZXRfYmluZCgpCgpUaGUgY2FsbCB0byBjcHVzZXRfYmluZCgpIGlzIGRvbmUgYWZ0ZXIg
c2V0dGluZyB0b3BfY3B1c2V0LmNzcy5jZ3JvdXAKdG8gdGhlICZjZ3JwX2RmbF9yb290LmNn
cnAuIFRoZSBhbGxvY2F0ZWQgdjEgY2dyb3VwIHJvb3Qgd2lsbCBiZSBmcmVlZAphZnRlciB0
aGUgY29tcGxldGlvbiBvZiB0aGUgY3B1c2V0X2JpbmQoKSBjYWxsIGFuZCBvdGhlciBtaXNj
ZWxsYW5lb3VzCmNsZWFudXBzLgoKRml4IHRoaXMgcG90ZW50aWFsIFVBRiBwcm9ibGVtIGJ5
IHB1dHRpbmcgdGhlIGFjY2VzcyBhbmQgcGFyc2luZwpvZiB0b3BfY3B1c2V0LmNzcy5jZ3Jv
dXAgdW5kZXIgY3B1c2V0X211dGV4IHRvIHN5bmNocm9uaXplIHdpdGgKY3B1c2V0X2JpbmQo
KSBvZiB0aGUgdW5tb3VudCBvcGVyYXRpb24uIElmIHRoZSBjcHVzZXRfbXV0ZXggaXMgYWNx
dWlyZWQKYWZ0ZXIgY3B1c2V0X2JpbmQoKSwgdG9wX2NwdXNldC5jc3MuY2dyb3VwIGlzIGd1
YXJhbnRlZWQgdG8gcG9pbnQgdG8KY2dycF9kZmxfcm9vdC5jZ3JwLiBJZiBpdCBpcyBhY3F1
aXJlZCBiZWZvcmUgY3B1c2V0X2JpbmQoKSwgdGhlIGFsbG9jYXRlZAp2MSBjZ3JvdXAgcm9v
dCBjYW5ub3QgYmUgZnJlZWQgdW50aWwgYWZ0ZXIgdGhlIGNwdXNldF9tdXRleCBpcyByZWxl
YXNlZC4KCkEgc2ltaWxhciBVQUYgcHJvYmxlbSBpbiBwcm9jX2NwdXNldF9zaG93KCkgaGFk
IGJlZW4gcmVwb3J0ZWQgYmVmb3JlIGluClsxXS4KClsxXSBodHRwczovL3N5emthbGxlci5h
cHBzcG90LmNvbS9idWc/ZXh0aWQ9OWIxZmY3YmU5NzRhNDAzYWE0Y2QKClJlcG9ydGVkLWJ5
OiBDaGVuIFJpZG9uZyA8Y2hlbnJpZG9uZ0BodWF3ZWkuY29tPgpDbG9zZXM6IGh0dHBzOi8v
c3l6a2FsbGVyLmFwcHNwb3QuY29tL2J1Zz9leHRpZD05YjFmZjdiZTk3NGE0MDNhYTRjZApT
aWduZWQtb2ZmLWJ5OiBXYWltYW4gTG9uZyA8bG9uZ21hbkByZWRoYXQuY29tPgotLS0KIGtl
cm5lbC9jZ3JvdXAvY3B1c2V0LmMgfCA3ICsrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA3IGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9rZXJuZWwvY2dyb3VwL2NwdXNldC5jIGIva2Vy
bmVsL2Nncm91cC9jcHVzZXQuYwppbmRleCBjMTJiOWZkYjIyYTQuLjk1MzE1MGEwNmQ4MSAx
MDA2NDQKLS0tIGEva2VybmVsL2Nncm91cC9jcHVzZXQuYworKysgYi9rZXJuZWwvY2dyb3Vw
L2NwdXNldC5jCkBAIC01MDUxLDEwICs1MDUxLDE3IEBAIGludCBwcm9jX2NwdXNldF9zaG93
KHN0cnVjdCBzZXFfZmlsZSAqbSwgc3RydWN0IHBpZF9uYW1lc3BhY2UgKm5zLAogCWlmICgh
YnVmKQogCQlnb3RvIG91dDsKIAorCS8qCisJICogQWNjZXNzIHRvIGNzcy0+Y2dyb3VwIGlz
IGd1YXJkZWQgYnkgY3B1c2V0X211dGV4IHRvIHN5bmNocm9uaXplCisJICogd2l0aCB0aGUg
Y3B1c2V0X2JpbmQoKSBjYWxsIG9mIGEgcmFjaW5nIHYxIGNncm91cCByb290IHVubW91bnQK
KwkgKiBvcGVyYXRpb24gdG8gcHJldmVudCBVQUYuCisJICovCisJbXV0ZXhfbG9jaygmY3B1
c2V0X211dGV4KTsKIAljc3MgPSB0YXNrX2dldF9jc3ModHNrLCBjcHVzZXRfY2dycF9pZCk7
CiAJcmV0dmFsID0gY2dyb3VwX3BhdGhfbnMoY3NzLT5jZ3JvdXAsIGJ1ZiwgUEFUSF9NQVgs
CiAJCQkJY3VycmVudC0+bnNwcm94eS0+Y2dyb3VwX25zKTsKIAljc3NfcHV0KGNzcyk7CisJ
bXV0ZXhfdW5sb2NrKCZjcHVzZXRfbXV0ZXgpOwogCWlmIChyZXR2YWwgPT0gLUUyQklHKQog
CQlyZXR2YWwgPSAtRU5BTUVUT09MT05HOwogCWlmIChyZXR2YWwgPCAwKQotLSAKMi4zOS4z
Cgo=

--------------zYFHqbA6TwbLQ80GIyHAX7jS--


