Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A453A746F
	for <lists+cgroups@lfdr.de>; Tue, 15 Jun 2021 04:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhFOC4C (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Jun 2021 22:56:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59024 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229613AbhFOC4C (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Jun 2021 22:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623725638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QdYxDbQWiJKAKMyRdXqAnaZNwtk+EcbNLD508mdqaII=;
        b=SnRF/3WapR3gHUhk/TYsu52nKeEZgnGutfGZsSrfuGKIgJgA2HJ17okApRwUsIPxBHzu9i
        WrFYbkIQIfWhQJjV1vlbdEzSbi9GrH0JOdz8j3uwDptla0OwQnvKN1JvXffW3B7xS7zh3z
        z+3zGtN5X0UgTuvwmsCMeOrVM5uiAL0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-Y9-uZreDPWuDYyKMeVBH3Q-1; Mon, 14 Jun 2021 22:53:56 -0400
X-MC-Unique: Y9-uZreDPWuDYyKMeVBH3Q-1
Received: by mail-qk1-f197.google.com with SMTP id c3-20020a37b3030000b02903ad0001a2e8so5663248qkf.3
        for <cgroups@vger.kernel.org>; Mon, 14 Jun 2021 19:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QdYxDbQWiJKAKMyRdXqAnaZNwtk+EcbNLD508mdqaII=;
        b=B1OKC96Im0uLOkzUFWt7nMYzdGFJSCQguGP2fffXllAS+1UVoaYX9KukbIm+VFJwId
         tmrwhrSPi6UtaekBvNKEW1q+CBKt5SExtK5PFyGALeWjFLAlJGLuK9X08s6Od7xl+IHw
         QDruZOiKg/OCHQBYiDYtF/cvsYilfz2RoXcJBEYXdHQ8eV+eEseEiaquUKXZl3CwE+pU
         kKcxDtgv4klnR9nNhu68BVY9lw6/WV1IUIf38jRFfXAyTXo3JEKrItqsGje/A/LWgqgr
         tz9WpNj7dbAxmpEgNVkjchQ/ppA5zHa0fraiwa68Kdd80heAZ1+AZ3GMQ94JD4jFYr8L
         aQqg==
X-Gm-Message-State: AOAM531Fosv9087/0irvacifu6B+yt9IhV1V2HhvvZCQB8UuDxpc2mtm
        NQnQvr8ZU+uUeUr/QDt0gRtF7+FfpaJeTYq0g50vrSvGAnufwLfvqyJZuAx04VJlR9NqMjkQAMG
        pV4NRBgQV6E1clvgiyQ==
X-Received: by 2002:a05:6214:d8e:: with SMTP id e14mr2632187qve.15.1623725636536;
        Mon, 14 Jun 2021 19:53:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzR4D5lIHl7MJuKgEWLvfkxmSWyUHGOXkAt4S7/aewovmlU2fF1+6INdneT3NVj66tHWWQPJA==
X-Received: by 2002:a05:6214:d8e:: with SMTP id e14mr2632175qve.15.1623725636385;
        Mon, 14 Jun 2021 19:53:56 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id b10sm11457721qkh.45.2021.06.14.19.53.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 19:53:55 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 0/4] cgroup/cpuset: Allow cpuset to bound displayed cpu
 info
To:     Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>, x86@kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20210614152306.25668-1-longman@redhat.com>
 <YMe/cGV4JPbzFRk0@slm.duckdns.org>
Message-ID: <0e21f16d-d91b-7cec-d832-4c401a713b10@redhat.com>
Date:   Mon, 14 Jun 2021 22:53:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YMe/cGV4JPbzFRk0@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 6/14/21 4:43 PM, Tejun Heo wrote:
> Hello,
>
> On Mon, Jun 14, 2021 at 11:23:02AM -0400, Waiman Long wrote:
>> The current container management system is able to create the illusion
>> that applications running within a container have limited resources and
>> devices available for their use. However, one thing that is hard to hide
>> is the number of CPUs available in the system. In fact, the container
>> developers are asking for the kernel to provide such capability.
>>
>> There are two places where cpu information are available for the
>> applications to see - /proc/cpuinfo and /sys/devices/system/cpu sysfs
>> directory.
>>
>> This patchset introduces a new sysctl parameter cpuset_bound_cpuinfo
>> which, when set, will limit the amount of information disclosed by
>> /proc/cpuinfo and /sys/devices/system/cpu.
> The goal of cgroup has never been masquerading system information so that
> applications can pretend that they own the whole system and the proposed
> solution requires application changes anyway. The information being provided
> is useful but please do so within the usual cgroup interface - e.g.
> cpuset.stat. The applications (or libraries) that want to determine its
> confined CPU availability can locate the file through /proc/self/cgroup.

Thanks for your comment. I understand your point making change via 
cgroup interface files. However, this is not what the customers are 
asking for. They are using tools that look at /proc/cpuinfo and the 
sysfs files. It is a much bigger effort to make all those tools look at 
a new cgroup file interface instead. It can be more efficiently done at 
the kernel level.

Anyway, I am OK if the consensus is that it is not a kernel problem and 
have to be handled in userspace.

BTW, do you have any comment on another cpuset patch that I sent a week 
earlier?

https://lore.kernel.org/lkml/20210603212416.25934-1-longman@redhat.com/

I am looking forward for your feedback.

Cheers,
Longman

