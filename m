Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938E5636B1D
	for <lists+cgroups@lfdr.de>; Wed, 23 Nov 2022 21:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239875AbiKWUbT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Nov 2022 15:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236036AbiKWUbD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Nov 2022 15:31:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53CFFF43E
        for <cgroups@vger.kernel.org>; Wed, 23 Nov 2022 12:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669235042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W6/q0I9lhD2Ic91IJouqxj39nsjVclbcOMvuo2nvzhI=;
        b=PkjOCtxJID0YwIHCsr2Eh8P2ckyXjsfEhDPis4sls6u20J0iO+REDf8g/ulfGN/VvkX3+9
        B+uIjxqrZS4T8s/xWiER2Wumd8iAI27dOkINEcfBkH5uaf96ObA1asrKgUgF6Rbu1/naVG
        d23Ug0ggqwWOjDa2AWrMT3fUdpGZsrs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-175-QBuExES4OmGx5AyWY2yy0Q-1; Wed, 23 Nov 2022 15:23:58 -0500
X-MC-Unique: QBuExES4OmGx5AyWY2yy0Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A6DE800B23;
        Wed, 23 Nov 2022 20:23:58 +0000 (UTC)
Received: from [10.22.17.47] (unknown [10.22.17.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F9C040C2086;
        Wed, 23 Nov 2022 20:23:57 +0000 (UTC)
Content-Type: multipart/mixed; boundary="------------UyHPKBK8yiP03gC4izCN5JwL"
Message-ID: <2ac6f207-e08a-2a7f-01ae-dfaf15eefaf6@redhat.com>
Date:   Wed, 23 Nov 2022 15:23:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] cgroup/cpuset: Optimize update_tasks_nodemask()
Content-Language: en-US
To:     "haifeng.xu" <haifeng.xu@shopee.com>
Cc:     lizefan.x@bytedance.com, tj@kernel.org, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221123082157.71326-1-haifeng.xu@shopee.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20221123082157.71326-1-haifeng.xu@shopee.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This is a multi-part message in MIME format.
--------------UyHPKBK8yiP03gC4izCN5JwL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/23/22 03:21, haifeng.xu wrote:
> When change the 'cpuset.mems' under some cgroup, system will hung
> for a long time. From the dmesg, many processes or theads are
> stuck in fork/exit. The reason is show as follows.
>
> thread A:
> cpuset_write_resmask /* takes cpuset_rwsem */
>    ...
>      update_tasks_nodemask
>        mpol_rebind_mm /* waits mmap_lock */
>
> thread B:
> worker_thread
>    ...
>      cpuset_migrate_mm_workfn
>        do_migrate_pages /* takes mmap_lock */
>
> thread C:
> cgroup_procs_write /* takes cgroup_mutex and cgroup_threadgroup_rwsem */
>    ...
>      cpuset_can_attach
>        percpu_down_write /* waits cpuset_rwsem */
>
> Once update the nodemasks of cpuset, thread A wakes up thread B to
> migrate mm. But when thread A iterates through all tasks, including
> child threads and group leader, it has to wait the mmap_lock which
> has been take by thread B. Unfortunately, thread C wants to migrate
> tasks into cgroup at this moment, it must wait thread A to release
> cpuset_rwsem. If thread B spends much time to migrate mm, the
> fork/exit which acquire cgroup_threadgroup_rwsem also need to
> wait for a long time.
>
> There is no need to migrate the mm of child threads which is
> shared with group leader. Just iterate through the group
> leader only.
>
> Signed-off-by: haifeng.xu <haifeng.xu@shopee.com>
> ---
>   kernel/cgroup/cpuset.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 589827ccda8b..43cbd09546d0 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1968,6 +1968,9 @@ static void update_tasks_nodemask(struct cpuset *cs)
>   
>   		cpuset_change_task_nodemask(task, &newmems);
>   
> +		if (!thread_group_leader(task))
> +			continue;
> +
>   		mm = get_task_mm(task);
>   		if (!mm)
>   			continue;

Could you try the attached test patch to see if it can fix your problem? 
Something along the line of this patch will be more acceptable.

Thanks,
Longman


--------------UyHPKBK8yiP03gC4izCN5JwL
Content-Type: text/x-patch; charset=UTF-8; name="test.patch"
Content-Disposition: attachment; filename="test.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2tlcm5lbC9jZ3JvdXAvY3B1c2V0LmMgYi9rZXJuZWwvY2dyb3VwL2Nw
dXNldC5jCmluZGV4IGI0NzQyODljMTViOC4uOWMxN2I2ZDQ4NzdjIDEwMDY0NAotLS0gYS9r
ZXJuZWwvY2dyb3VwL2NwdXNldC5jCisrKyBiL2tlcm5lbC9jZ3JvdXAvY3B1c2V0LmMKQEAg
LTE5NDIsNiArMTk0Miw3IEBAIHN0YXRpYyB2b2lkIHVwZGF0ZV90YXNrc19ub2RlbWFzayhz
dHJ1Y3QgY3B1c2V0ICpjcykKIAlzdGF0aWMgbm9kZW1hc2tfdCBuZXdtZW1zOwkvKiBwcm90
ZWN0ZWQgYnkgY3B1c2V0X3J3c2VtICovCiAJc3RydWN0IGNzc190YXNrX2l0ZXIgaXQ7CiAJ
c3RydWN0IHRhc2tfc3RydWN0ICp0YXNrOworCWJvb2wgbWlncmF0ZTsKIAogCWNwdXNldF9i
ZWluZ19yZWJvdW5kID0gY3M7CQkvKiBjYXVzZXMgbXBvbF9kdXAoKSByZWJpbmQgKi8KIApA
QCAtMTk1NywxOSArMTk1OCwyNSBAQCBzdGF0aWMgdm9pZCB1cGRhdGVfdGFza3Nfbm9kZW1h
c2soc3RydWN0IGNwdXNldCAqY3MpCiAJICogSXQncyBvayBpZiB3ZSByZWJpbmQgdGhlIHNh
bWUgbW0gdHdpY2U7IG1wb2xfcmViaW5kX21tKCkKIAkgKiBpcyBpZGVtcG90ZW50LiAgQWxz
byBtaWdyYXRlIHBhZ2VzIGluIGVhY2ggbW0gdG8gbmV3IG5vZGVzLgogCSAqLworCW1pZ3Jh
dGUgPSBpc19tZW1vcnlfbWlncmF0ZShjcyk7CiAJY3NzX3Rhc2tfaXRlcl9zdGFydCgmY3Mt
PmNzcywgMCwgJml0KTsKIAl3aGlsZSAoKHRhc2sgPSBjc3NfdGFza19pdGVyX25leHQoJml0
KSkpIHsKIAkJc3RydWN0IG1tX3N0cnVjdCAqbW07Ci0JCWJvb2wgbWlncmF0ZTsKIAogCQlj
cHVzZXRfY2hhbmdlX3Rhc2tfbm9kZW1hc2sodGFzaywgJm5ld21lbXMpOwogCisJCS8qCisJ
CSAqIFNraXAgbW0gdXBkYXRlIGlmIGEgbm9uIGdyb3VwIGxlYWRlciB0YXNrIGFuZCBpdHMg
Z3JvdXAKKwkJICogbGVhZGVyIGFyZSBpbiB0aGUgc2FtZSBjcHVzZXQuCisJCSAqLworCQlp
ZiAoIXRocmVhZF9ncm91cF9sZWFkZXIodGFzaykgJiYKKwkJICAgKHRhc2tfY3ModGFzay0+
Z3JvdXBfbGVhZGVyKSA9PSBjcykpCisJCQljb250aW51ZTsKKwogCQltbSA9IGdldF90YXNr
X21tKHRhc2spOwogCQlpZiAoIW1tKQogCQkJY29udGludWU7CiAKLQkJbWlncmF0ZSA9IGlz
X21lbW9yeV9taWdyYXRlKGNzKTsKLQogCQltcG9sX3JlYmluZF9tbShtbSwgJmNzLT5tZW1z
X2FsbG93ZWQpOwogCQlpZiAobWlncmF0ZSkKIAkJCWNwdXNldF9taWdyYXRlX21tKG1tLCAm
Y3MtPm9sZF9tZW1zX2FsbG93ZWQsICZuZXdtZW1zKTsK

--------------UyHPKBK8yiP03gC4izCN5JwL--

