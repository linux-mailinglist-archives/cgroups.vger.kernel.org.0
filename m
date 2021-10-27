Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA4243C006
	for <lists+cgroups@lfdr.de>; Wed, 27 Oct 2021 04:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbhJ0CiK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Oct 2021 22:38:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59876 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234283AbhJ0CiK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Oct 2021 22:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635302145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZGUktUxKSDawe5cfrBBp7LiAKurPgQ7WEWiThb4tO84=;
        b=AnXggKiMLWnBBVx4FJ8HdZnkvwEG30Cx2DX56eyZ4FbNd7Wvvf/CIytZfCcw6QqXs4tmrx
        duAjVynq+bclCENpQ1UTYpptrhfARrtKPg+8rtjcrGY1132Nt/boQeUwxCfpD2sWhxRjna
        0zfQR4dGv4F2wtHa8+28i8CpbcRzghQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-alal8p15ORiT81NlvQelWA-1; Tue, 26 Oct 2021 22:35:40 -0400
X-MC-Unique: alal8p15ORiT81NlvQelWA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2173010A8E00;
        Wed, 27 Oct 2021 02:35:38 +0000 (UTC)
Received: from llong.remote.csb (unknown [10.22.18.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED7D7ADD8;
        Wed, 27 Oct 2021 02:35:35 +0000 (UTC)
Subject: Re: [PATCH RFC] cpuset: Make cpusets get restored on hotplug
To:     Barry Song <21cnbao@gmail.com>
Cc:     amit.pundir@linaro.org, cgroups@vger.kernel.org,
        Dmitry Shmidt <dimitrysh@google.com>, groeck@chromium.org,
        hannes@cmpxchg.org, joel@joelfernandes.org, jsbarnes@google.com,
        kernel-team@android.com, kerrnel@google.com,
        LKML <linux-kernel@vger.kernel.org>, lizefan@huawei.com,
        Peter Zijlstra <peterz@infradead.org>, sonnyrao@google.com,
        Tejun Heo <tj@kernel.org>, vpillai@digitalocean.com
References: <972a5c1b-6721-ac20-cec5-617af67e617d@redhat.com>
 <20211026235808.34168-1-21cnbao@gmail.com>
 <f795f8be-a184-408a-0b5a-553d26061385@redhat.com>
 <CAGsJ_4wZJyKh+FUsmL8TMaCHofmr9J5UCzk3YYEYckD8ZWZW+w@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
Message-ID: <4637ebd4-61ef-5ad6-d2bd-976663f5c4a1@redhat.com>
Date:   Tue, 26 Oct 2021 22:35:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAGsJ_4wZJyKh+FUsmL8TMaCHofmr9J5UCzk3YYEYckD8ZWZW+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 10/26/21 10:21 PM, Barry Song wrote:
> On Wed, Oct 27, 2021 at 2:06 PM Waiman Long <longman@redhat.com> wrote:
>>
>> On 10/26/21 7:58 PM, Barry Song wrote:
>>>> I think Tejun is concerned about a change in the default behavior of
>>>> cpuset v1.
>>>>
>>>> There is a special v2 mode for cpuset that is enabled by the mount
>>>> option "cpuset_v2_mode". This causes the cpuset v1 to adopt some of the
>>>> v2 behavior. I introduced this v2 mode a while back to address, I think,
>>>> a similar concern. Could you try that to see if it is able to address
>>>> your problem? If not, you can make some code adjustment within the
>>>> framework of the v2 mode. As long as it is an opt-in, I think we are
>>>> open to further change.
>>> I am also able to reproduce on Ubuntu 21.04 LTS.
>>>
>>> all docker will be put in this cgroups and its child cgroups:
>>> /sys/fs/cgroup/cpuset/docker
>>>
>>> disabling and enabling SMT by:
>>> echo off > /sys/devices/system/cpu/smt/control
>>> echo on > /sys/devices/system/cpu/smt/control
>>>
>>> or unpluging and pluging CPUs by:
>>> echo 0 > /sys/devices/system/cpu/cpuX/online
>>> echo 1 > /sys/devices/system/cpu/cpuX/online
>>>
>>> then all docker images will lose some CPUs.
>>>
>>> So should we document the broken behaviours somewhere?
>> Is the special cpuset_v2_mode mount option able to fix the issue?
>>
>> This mode is documented in
>>
>> Documentation/admin-guide/cgroup-v1/cpuset.rst:
>>
>> The cpuset.effective_cpus and cpuset.effective_mems files are
>> normally read-only copies of cpuset.cpus and cpuset.mems files
>> respectively.  If the cpuset cgroup filesystem is mounted with the
>> special "cpuset_v2_mode" option, the behavior of these files will become
>> similar to the corresponding files in cpuset v2.  In other words, hotplug
>> events will not change cpuset.cpus and cpuset.mems.  Those events will
>> only affect cpuset.effective_cpus and cpuset.effective_mems which show
>> the actual cpus and memory nodes that are currently used by this cpuset.
>> See Documentation/admin-guide/cgroup-v2.rst for more information about
>> cpuset v2 behavior.
>>
>> Maybe we can make it more visible.
> Is it possible to make cpuset_v2_mode true in default? not quite sure if
> it will harm something.

The cpuset_v2_mode is a change in v1 behavior and that is why it is an 
opt-in as we don't want to break existing applications that have a 
dependency on the current v1 behavior. If users switch to use cgroup v2, 
they get the new behavior. Alternately, they can modify the system 
startup script to use the v2 behavior by using the mount option. I don't 
think we are going to change the v1 default behavior.

Cheers,
Longman

