Return-Path: <cgroups+bounces-3281-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CA79134A1
	for <lists+cgroups@lfdr.de>; Sat, 22 Jun 2024 17:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88CC62846D6
	for <lists+cgroups@lfdr.de>; Sat, 22 Jun 2024 15:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB5916F90F;
	Sat, 22 Jun 2024 15:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZZruuU8"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B78516F298
	for <cgroups@vger.kernel.org>; Sat, 22 Jun 2024 15:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719068746; cv=none; b=SSUUsISCaGVzx8KL9GSS6J+p30EO5y79gwXwwYK2Rr81hMuJIbV93huOnrD+m1trpqdbsepoPSFgj6UCH0USjGNVCpdQ0r+/Eu+F4ElQTYZznbr8v1s/xHoWJTHdbrcH2XM9a/eJp62Q+h8CDS91j2t0nqfzTq6K+L9ouateQyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719068746; c=relaxed/simple;
	bh=3enL4wUGDAZMVURNyY16KWwZTBvTG7m3spx6le4opy0=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=osA6IyNvJUX2oSo4nHa3tXLlaLxNo28bwi6VlCRGc+s+Lr37rzGXSNmF+1fvRooiJ2OGES4RuWfFQe7NeQ7t9Atp8sakimLk5v5sVNUVSazqPKHcteIKq9jstXY5nMKKD/fl+cCIWmiL5OgHsnMHLK9xFgrBC/7NBdIeiebW4ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZZZruuU8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719068742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/+8g60G0lhv/qw202X53m0GXz11BlNrxUr8prXXV21U=;
	b=ZZZruuU8A+rO50c9Fu3Cl7mTaPKFy7NFZs8P3cU9ggKas+JYQUH7zL0rwt7sX/6nV6n5Vv
	xVozQGHLJftwkcTACodPeK1MjndurvFrE8O6rZ7iCmHBLa3Q4hF5uRZ56j285bGrx/iY2y
	objnPRvRoQGGkb+o5FVnpZzqPYK2vBc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-4wE2YACQOGekFk3m841teQ-1; Sat,
 22 Jun 2024 11:05:36 -0400
X-MC-Unique: 4wE2YACQOGekFk3m841teQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A688819560B3;
	Sat, 22 Jun 2024 15:05:34 +0000 (UTC)
Received: from [10.22.32.34] (unknown [10.22.32.34])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D75D83000218;
	Sat, 22 Jun 2024 15:05:32 +0000 (UTC)
Content-Type: multipart/mixed; boundary="------------mFciyHh21cUdSkSuEk1hN0X0"
Message-ID: <19648b9c-6df7-45cd-a5ae-624a3e4d860f@redhat.com>
Date: Sat, 22 Jun 2024 11:05:31 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup: fix uaf when proc_cpuset_show
To: Chen Ridong <chenridong@huawei.com>, tj@kernel.org,
 lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc: bpf@vger.kernel.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240622113814.120907-1-chenridong@huawei.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240622113814.120907-1-chenridong@huawei.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This is a multi-part message in MIME format.
--------------mFciyHh21cUdSkSuEk1hN0X0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/22/24 07:38, Chen Ridong wrote:
> We found a refcount UAF bug as follows:
>
> BUG: KASAN: use-after-free in cgroup_path_ns+0x112/0x150
> Read of size 8 at addr ffff8882a4b242b8 by task atop/19903
>
> CPU: 27 PID: 19903 Comm: atop Kdump: loaded Tainted: GF
> Call Trace:
>   dump_stack+0x7d/0xa7
>   print_address_description.constprop.0+0x19/0x170
>   ? cgroup_path_ns+0x112/0x150
>   __kasan_report.cold+0x6c/0x84
>   ? print_unreferenced+0x390/0x3b0
>   ? cgroup_path_ns+0x112/0x150
>   kasan_report+0x3a/0x50
>   cgroup_path_ns+0x112/0x150
>   proc_cpuset_show+0x164/0x530
>   proc_single_show+0x10f/0x1c0
>   seq_read_iter+0x405/0x1020
>   ? aa_path_link+0x2e0/0x2e0
>   seq_read+0x324/0x500
>   ? seq_read_iter+0x1020/0x1020
>   ? common_file_perm+0x2a1/0x4a0
>   ? fsnotify_unmount_inodes+0x380/0x380
>   ? bpf_lsm_file_permission_wrapper+0xa/0x30
>   ? security_file_permission+0x53/0x460
>   vfs_read+0x122/0x420
>   ksys_read+0xed/0x1c0
>   ? __ia32_sys_pwrite64+0x1e0/0x1e0
>   ? __audit_syscall_exit+0x741/0xa70
>   do_syscall_64+0x33/0x40
>   entry_SYSCALL_64_after_hwframe+0x67/0xcc
>
> This is also reported by: https://syzkaller.appspot.com/bug?extid=9b1ff7be974a403aa4cd
>
> This can be reproduced by the following methods:
> 1.add an mdelay(1000) before acquiring the cgroup_lock In the
>   cgroup_path_ns function.
> 2.$cat /proc/<pid>/cpuset   repeatly.
> 3.$mount -t cgroup -o cpuset cpuset /sys/fs/cgroup/cpuset/
> $umount /sys/fs/cgroup/cpuset/   repeatly.
>
> The race that cause this bug can be shown as below:
>
> (umount)		|	(cat /proc/<pid>/cpuset)
> css_release		|	proc_cpuset_show
> css_release_work_fn	|	css = task_get_css(tsk, cpuset_cgrp_id);
> css_free_rwork_fn	|	cgroup_path_ns(css->cgroup, ...);
> cgroup_destroy_root	|	mutex_lock(&cgroup_mutex);
> rebind_subsystems	|
> cgroup_free_root 	|
> 			|	// cgrp was freed, UAF
> 			|	cgroup_path_ns_locked(cgrp,..);
>
> When the cpuset is initialized, the root node top_cpuset.css.cgrp
> will point to &cgrp_dfl_root.cgrp. In cgroup v1, the mount operation will
> allocate cgroup_root, and top_cpuset.css.cgrp will point to the allocated
> &cgroup_root.cgrp. When the umount operation is executed,
> top_cpuset.css.cgrp will be rebound to &cgrp_dfl_root.cgrp.
>
> The problem is that when rebinding to cgrp_dfl_root, there are cases
> where the cgroup_root allocated by setting up the root for cgroup v1
> is cached. This could lead to a Use-After-Free (UAF) if it is
> subsequently freed. The descendant cgroups of cgroup v1 can only be
> freed after the css is released. However, the css of the root will never
> be released, yet the cgroup_root should be freed when it is unmounted.
> This means that obtaining a reference to the css of the root does
> not guarantee that css.cgrp->root will not be freed.
>
> To solve this issue, we have added a cgroup reference count in
> the proc_cpuset_show function to ensure that css.cgrp->root will not
> be freed prematurely. This is a temporary solution. Let's see if anyone
> has a better solution.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index c12b9fdb22a4..782eaf807173 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -5045,6 +5045,7 @@ int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
>   	char *buf;
>   	struct cgroup_subsys_state *css;
>   	int retval;
> +	struct cgroup *root_cgroup = NULL;
>   
>   	retval = -ENOMEM;
>   	buf = kmalloc(PATH_MAX, GFP_KERNEL);
> @@ -5052,9 +5053,28 @@ int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
>   		goto out;
>   
>   	css = task_get_css(tsk, cpuset_cgrp_id);
> +	rcu_read_lock();
> +	/*
> +	 * When the cpuset subsystem is mounted on the legacy hierarchy,
> +	 * the top_cpuset.css->cgroup does not hold a reference count of
> +	 * cgroup_root.cgroup. This makes accessing css->cgroup very
> +	 * dangerous because when the cpuset subsystem is remounted to the
> +	 * default hierarchy, the cgroup_root.cgroup that css->cgroup points
> +	 * to will be released, leading to a UAF issue. To avoid this problem,
> +	 * get the reference count of top_cpuset.css->cgroup first.
> +	 *
> +	 * This is ugly!!
> +	 */
> +	if (css == &top_cpuset.css) {
> +		cgroup_get(css->cgroup);
> +		root_cgroup = css->cgroup;
> +	}
> +	rcu_read_unlock();
>   	retval = cgroup_path_ns(css->cgroup, buf, PATH_MAX,
>   				current->nsproxy->cgroup_ns);
>   	css_put(css);
> +	if (root_cgroup)
> +		cgroup_put(root_cgroup);
>   	if (retval == -E2BIG)
>   		retval = -ENAMETOOLONG;
>   	if (retval < 0)

Thanks for reporting this UAF bug. Could you try the attached patch to 
see if it can fix the issue?

Cheers,
Longman

--------------mFciyHh21cUdSkSuEk1hN0X0
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-cgroup-cpuset-Prevent-UAF-in-proc_cpuset_show.patch"
Content-Disposition: attachment;
 filename="0001-cgroup-cpuset-Prevent-UAF-in-proc_cpuset_show.patch"
Content-Transfer-Encoding: base64

RnJvbSAxMTAzNmQwMjdjYzFmM2RkMGE2MDQ1Nzk0ZmI4NzcxMWM4NDBmNDI2IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBXYWltYW4gTG9uZyA8bG9uZ21hbkByZWRoYXQuY29t
PgpEYXRlOiBTYXQsIDIyIEp1biAyMDI0IDEwOjI1OjE1IC0wNDAwClN1YmplY3Q6IFtQQVRD
SF0gY2dyb3VwL2NwdXNldDogUHJldmVudCBVQUYgaW4gcHJvY19jcHVzZXRfc2hvdygpCgpB
biBVQUYgY2FuIGhhcHBlbiB3aGVuIC9wcm9jL2NwdXNldCBpcyByZWFkIGFzIHJlcG9ydGVk
IGluIFsxXS4KCldoZW4gdGhlIGNwdXNldCBpcyBpbml0aWFsaXplZCwgdGhlIHJvb3Qgbm9k
ZSB0b3BfY3B1c2V0LmNzcy5jZ3JwCndpbGwgcG9pbnQgdG8gJmNncnBfZGZsX3Jvb3QuY2dy
cC4gSW4gY2dyb3VwIHYxLCB0aGUgbW91bnQgb3BlcmF0aW9uIHdpbGwKYWxsb2NhdGUgY2dy
b3VwX3Jvb3QsIGFuZCB0b3BfY3B1c2V0LmNzcy5jZ3JwIHdpbGwgcG9pbnQgdG8gdGhlIGFs
bG9jYXRlZAomY2dyb3VwX3Jvb3QuY2dycC4gV2hlbiB0aGUgdW1vdW50IG9wZXJhdGlvbiBp
cyBleGVjdXRlZCwKdG9wX2NwdXNldC5jc3MuY2dycCB3aWxsIGJlIHJlYm91bmQgdG8gJmNn
cnBfZGZsX3Jvb3QuY2dycC4KClRoZSBwcm9ibGVtIGlzIHRoYXQgd2hlbiByZWJpbmRpbmcg
dG8gY2dycF9kZmxfcm9vdCwgdGhlcmUgYXJlIGNhc2VzCndoZXJlIHRoZSBjZ3JvdXBfcm9v
dCBhbGxvY2F0ZWQgYnkgc2V0dGluZyB1cCB0aGUgcm9vdCBmb3IgY2dyb3VwIHYxCmlzIGNh
Y2hlZC4gVGhpcyBjb3VsZCBsZWFkIHRvIGEgVXNlLUFmdGVyLUZyZWUgKFVBRikgaWYgaXQg
aXMKc3Vic2VxdWVudGx5IGZyZWVkLiBUaGUgZGVzY2VuZGFudCBjZ3JvdXBzIG9mIGNncm91
cCB2MSBjYW4gb25seSBiZQpmcmVlZCBhZnRlciB0aGUgY3NzIGlzIHJlbGVhc2VkLiBIb3dl
dmVyLCB0aGUgY3NzIG9mIHRoZSByb290IHdpbGwgbmV2ZXIKYmUgcmVsZWFzZWQsIHlldCB0
aGUgY2dyb3VwX3Jvb3Qgc2hvdWxkIGJlIGZyZWVkIHdoZW4gaXQgaXMgdW5tb3VudGVkLgpU
aGlzIG1lYW5zIHRoYXQgb2J0YWluaW5nIGEgcmVmZXJlbmNlIHRvIHRoZSBjc3Mgb2YgdGhl
IHJvb3QgZG9lcwpub3QgZ3VhcmFudGVlIHRoYXQgY3NzLmNncnAtPnJvb3Qgd2lsbCBub3Qg
YmUgZnJlZWQuCgpGaXggdGhpcyBwcm9ibGVtIGJ5IHRha2luZyBhIHJlZmVyZW5jZSB0byB0
aGUgdjEgY2dyb3VwIHJvb3QgaW4KY3B1c2V0X2JpbmQoKSBhbmQgcmVsZWFzZSBpdCBpbiB0
aGUgbmV4dCBjcHVzZXRfYmluZCgpIGNhbGwuIFRoZQp0b3BfY3B1c2V0IHdpbGwgYWx3YXlz
IGJlIGJvdW5kIHRvIGVpdGhlciBjZ3JwX2RmbF9yb290IG9yIHRoZQphbGxvY2F0ZWQgdjEg
Y2dyb3VwIHJvb3QuIFNvIHRvcF9jcHVzZXQgd2lsbCBhbHdheXMgYmUgcmVtb3VudGVkIGJh
Y2sKdG8gY2dycF9kZmxfcm9vdCB3aGVuZXZlciBhIHYxIGNwdXNldCBtb3VudCBpcyByZWxl
YXNlZC4KCkFjY2VzcyB0byBjc3MtPmNncm91cCBpbiBwcm9jX2NwdXNldF9zaG93KCkgaXMg
bm93IHByb3RlY3RlZCB1bmRlcgp0aGUgY3B1c2V0X211dGV4IHRvIG1ha2Ugc3VyZSB0aGF0
IGFuIFVBRiBhY2Nlc3MgdG8gY3NzLT5jZ3JvdXAgaXMKbm90IHBvc3NpYmxlLgoKWzFdIGh0
dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL2J1Zz9leHRpZD05YjFmZjdiZTk3NGE0MDNh
YTRjZAoKUmVwb3J0ZWQtYnk6IENoZW4gUmlkb25nIDxjaGVucmlkb25nQGh1YXdlaS5jb20+
CkNsb3NlczogaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20vYnVnP2V4dGlkPTliMWZm
N2JlOTc0YTQwM2FhNGNkClNpZ25lZC1vZmYtYnk6IFdhaW1hbiBMb25nIDxsb25nbWFuQHJl
ZGhhdC5jb20+Ci0tLQoga2VybmVsL2Nncm91cC9jcHVzZXQuYyB8IDE3ICsrKysrKysrKysr
KysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBh
L2tlcm5lbC9jZ3JvdXAvY3B1c2V0LmMgYi9rZXJuZWwvY2dyb3VwL2NwdXNldC5jCmluZGV4
IGMxMmI5ZmRiMjJhNC4uODE1NWFkOWZmOTI3IDEwMDY0NAotLS0gYS9rZXJuZWwvY2dyb3Vw
L2NwdXNldC5jCisrKyBiL2tlcm5lbC9jZ3JvdXAvY3B1c2V0LmMKQEAgLTQxNDMsOSArNDE0
MywyMCBAQCBzdGF0aWMgdm9pZCBjcHVzZXRfY3NzX2ZyZWUoc3RydWN0IGNncm91cF9zdWJz
eXNfc3RhdGUgKmNzcykKIAlmcmVlX2NwdXNldChjcyk7CiB9CiAKKy8qCisgKiBXaXRoIGEg
Y2dyb3VwIHYxIG1vdW50LCByb290X2Nzcy5jZ3JvdXAgY2FuIGJlIGZyZWVkLiBXZSBuZWVk
IHRvIHRha2UgYQorICogcmVmZXJlbmNlIHRvIGl0IHRvIGF2b2lkIFVBRiBhcyBwcm9jX2Nw
dXNldF9zaG93KCkgbWF5IGFjY2VzcyB0aGUgY29udGVudAorICogb2YgdGhpcyBjZ3JvdXAu
CisgKi8KIHN0YXRpYyB2b2lkIGNwdXNldF9iaW5kKHN0cnVjdCBjZ3JvdXBfc3Vic3lzX3N0
YXRlICpyb290X2NzcykKIHsKKwlzdGF0aWMgc3RydWN0IGNncm91cCAqdjFfY2dyb3VwX3Jv
b3Q7CisKIAltdXRleF9sb2NrKCZjcHVzZXRfbXV0ZXgpOworCWlmICh2MV9jZ3JvdXBfcm9v
dCkgeworCQljZ3JvdXBfcHV0KHYxX2Nncm91cF9yb290KTsKKwkJdjFfY2dyb3VwX3Jvb3Qg
PSBOVUxMOworCX0KIAlzcGluX2xvY2tfaXJxKCZjYWxsYmFja19sb2NrKTsKIAogCWlmIChp
c19pbl92Ml9tb2RlKCkpIHsKQEAgLTQxNTksNiArNDE3MCwxMCBAQCBzdGF0aWMgdm9pZCBj
cHVzZXRfYmluZChzdHJ1Y3QgY2dyb3VwX3N1YnN5c19zdGF0ZSAqcm9vdF9jc3MpCiAJfQog
CiAJc3Bpbl91bmxvY2tfaXJxKCZjYWxsYmFja19sb2NrKTsKKwlpZiAoIWNncm91cF9zdWJz
eXNfb25fZGZsKGNwdXNldF9jZ3JwX3N1YnN5cykpIHsKKwkJdjFfY2dyb3VwX3Jvb3QgPSBy
b290X2Nzcy0+Y2dyb3VwOworCQljZ3JvdXBfZ2V0KHYxX2Nncm91cF9yb290KTsKKwl9CiAJ
bXV0ZXhfdW5sb2NrKCZjcHVzZXRfbXV0ZXgpOwogfQogCkBAIC01MDUxLDEwICs1MDY2LDEy
IEBAIGludCBwcm9jX2NwdXNldF9zaG93KHN0cnVjdCBzZXFfZmlsZSAqbSwgc3RydWN0IHBp
ZF9uYW1lc3BhY2UgKm5zLAogCWlmICghYnVmKQogCQlnb3RvIG91dDsKIAorCW11dGV4X2xv
Y2soJmNwdXNldF9tdXRleCk7CiAJY3NzID0gdGFza19nZXRfY3NzKHRzaywgY3B1c2V0X2Nn
cnBfaWQpOwogCXJldHZhbCA9IGNncm91cF9wYXRoX25zKGNzcy0+Y2dyb3VwLCBidWYsIFBB
VEhfTUFYLAogCQkJCWN1cnJlbnQtPm5zcHJveHktPmNncm91cF9ucyk7CiAJY3NzX3B1dChj
c3MpOworCW11dGV4X3VubG9jaygmY3B1c2V0X211dGV4KTsKIAlpZiAocmV0dmFsID09IC1F
MkJJRykKIAkJcmV0dmFsID0gLUVOQU1FVE9PTE9ORzsKIAlpZiAocmV0dmFsIDwgMCkKLS0g
CjIuMzkuMwoK

--------------mFciyHh21cUdSkSuEk1hN0X0--


