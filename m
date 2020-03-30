Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3354A197DDE
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2020 16:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgC3OHk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 30 Mar 2020 10:07:40 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:48191 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727797AbgC3OHk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 30 Mar 2020 10:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585577259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9LrxmkAvaSght2/9QdSVfP4wqkPdT52lYY1qjr1mVKY=;
        b=NtzhiFl3dLUOBW/XmamoePr514iQozrskjMUH9NQ6Qx5GDHXWQbLM3WppkjIFL/BS3hR5V
        2kpIsECicjNES8MYmybzmBDrYAT5dVLhlZH2ckkM1ej4+gAV/P7Vy8dj+h5xgy/Cd6MQez
        w8H6mIt3bz9LjNydpBzJo/dObFfv5kA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-5NXvyPVMOWiYxqgB3CFbtQ-1; Mon, 30 Mar 2020 10:07:35 -0400
X-MC-Unique: 5NXvyPVMOWiYxqgB3CFbtQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1E1C800D50;
        Mon, 30 Mar 2020 14:07:33 +0000 (UTC)
Received: from llong.remote.csb (ovpn-116-140.rdu2.redhat.com [10.10.116.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C586A60C85;
        Mon, 30 Mar 2020 14:07:32 +0000 (UTC)
Subject: Re: [PATCH v2] docs: cgroup-v1: Document the cpuset_v2_mode mount
 option
To:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Sonny Rao <sonnyrao@google.com>
References: <20200330140615.25549-1-longman@redhat.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <1b25bc58-b916-660f-090a-1a1f13a4656d@redhat.com>
Date:   Mon, 30 Mar 2020 10:07:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200330140615.25549-1-longman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 3/30/20 10:06 AM, Waiman Long wrote:
> The cpuset in cgroup v1 accepts a special "cpuset_v2_mode" mount
> option that make cpuset.cpus and cpuset.mems behave more like those in
> cgroup v2.  Document it to make other people more aware of this feature
> that can be useful in some circumstances.
>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  Documentation/admin-guide/cgroup-v1/cpusets.rst | 11 +++++++++++
>  kernel/cgroup/cpuset.c                          |  8 ++++++--
>  2 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v1/cpusets.rst b/Documentation/admin-guide/cgroup-v1/cpusets.rst
> index 86a6ae995d54..7ade3abd342a 100644
> --- a/Documentation/admin-guide/cgroup-v1/cpusets.rst
> +++ b/Documentation/admin-guide/cgroup-v1/cpusets.rst
> @@ -223,6 +223,17 @@ cpu_online_mask using a CPU hotplug notifier, and the mems file
>  automatically tracks the value of node_states[N_MEMORY]--i.e.,
>  nodes with memory--using the cpuset_track_online_nodes() hook.
>  
> +The cpuset.effective_cpus and cpuset.effective_mems files are
> +normally read-only copies of cpuset.cpus and cpuset.mems files
> +respectively.  If the cpuset cgroup filesystem is mounted with the
> +special "cpuset_v2_mode" option, the behavior of these files will become
> +similar to the corresponding files in cpuset v2.  In other words, hotplug
> +events will not change cpuset.cpus and cpuset.mems.  Those events will
> +only affect cpuset.effective_cpus and cpuset.effective_mems which show
> +the actual cpus and memory nodes that are currently used by this cpuset.
> +See Documentation/admin-guide/cgroup-v2.rst for more information about
> +cpuset v2 behavior.
> +
>  
>  1.4 What are exclusive cpusets ?
>  --------------------------------
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 58f5073acff7..729d3a5c772e 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -358,8 +358,12 @@ static DECLARE_WORK(cpuset_hotplug_work, cpuset_hotplug_workfn);
>  static DECLARE_WAIT_QUEUE_HEAD(cpuset_attach_wq);
>  
>  /*
> - * Cgroup v2 behavior is used when on default hierarchy or the
> - * cgroup_v2_mode flag is set.
> + * Cgroup v2 behavior is used on the "cpus" and "mems" control files when
> + * on default hierarchy or when the cpuset_v2_mode flag is set by mounting
> + * the v1 cpuset cgroup filesystem with the "cpuset_v2_mode" mount option.
> + * With v2 behavior, "cpus" and "mems" are always what the users have
> + * requested and won't be changed by hotplug events. Only the effective
> + * cpus or mems will be affected.
>   */
>  static inline bool is_in_v2_mode(void)
>  {

On second thought, I should have clarified the cpuset_v2_mode option in
the cpuset.c file itself also.

Cheers,
Longman

