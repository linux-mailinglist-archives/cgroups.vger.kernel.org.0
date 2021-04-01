Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A65351CEF
	for <lists+cgroups@lfdr.de>; Thu,  1 Apr 2021 20:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237486AbhDASXF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Apr 2021 14:23:05 -0400
Received: from foss.arm.com ([217.140.110.172]:46420 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238228AbhDASUH (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 1 Apr 2021 14:20:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27CFB1596;
        Thu,  1 Apr 2021 07:06:08 -0700 (PDT)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44EA93F719;
        Thu,  1 Apr 2021 07:06:06 -0700 (PDT)
Date:   Thu, 1 Apr 2021 15:06:03 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexey Klimov <aklimov@redhat.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, peterz@infradead.org,
        yury.norov@gmail.com, daniel.m.jordan@oracle.com,
        jobaker@redhat.com, audralmitchel@gmail.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, rafael@kernel.org, tj@kernel.org,
        hannes@cmpxchg.org, klimov.linux@gmail.com
Subject: Re: [PATCH v3] cpu/hotplug: wait for cpuset_hotplug_work to finish
 on cpu onlining
Message-ID: <20210401140603.hvtbxjxw2izuhwus@e107158-lin>
References: <20210317003616.2817418-1-aklimov@redhat.com>
 <87tuowcnv3.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87tuowcnv3.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 03/27/21 22:01, Thomas Gleixner wrote:
> And while you carefully reworded the comment, did you actually read what
> it said and what is says now?
> 
> > -		 * cpu_down() which takes cpu maps lock. cpu maps lock
> > -		 * needs to be held as this might race against in kernel
> > -		 * abusers of the hotplug machinery (thermal management).
> 
> vs.
> 
> > +	 * cpu_down() which takes cpu maps lock. cpu maps lock
> > +	 * needed to be held as this might race against in-kernel
> > +	 * abusers of the hotplug machinery (thermal management).
> 
> The big fat hint is: "cpu maps lock needs to be held as this ...." and
> it still needs to be held for the above loop to work correctly at
> all. See also below.
> 
> So just moving comments blindly around and making them past tense is not
> cutting it. Quite the contrary the comments make no sense anymore. They
> became uncomprehensible word salad.
> 
> Now for the second part of that comment:
> 
> > +      *                                          ....  This is
> > +	 * called under the sysfs hotplug lock, so it is properly
> > +	 * serialized against the regular offline usage.
> 
> So there are two layers of protection:
> 
>    cpu_maps_lock and sysfs hotplug lock
> 
> One protects surprisingly against concurrent sysfs writes and the other
> is required to serialize in kernel usage.
> 
> Now lets look at the original protection:
> 
>    lock(sysfs)
>      lock(cpu_maps)
>        hotplug
>         dev->offline = new_state
>         uevent()
>      unlock(cpu_maps)
>    unlock(sysfs)
> 
> and the one you created:
> 
>    lock(sysfs)
>      lock(cpu_maps)
>        hotplug
>      unlock(cpu_maps)
>      dev->offline = new_state
>      uevent()
>    unlock(sysfs)
> 
> Where is that protection scope change mentioned in the change log and
> where is the analysis that it is correct?

The comment do still need updating though. Its reference to thermal management
is cryptic. I couldn't see who performs hotplug operations in thermal code.

I also think generally that comment is no longer valid after the refactor I did
to 'prevent' in-kernel users from calling cpu_up/down() directly and force them
all to go via device_offline/online() which is wrapped via the add/remove_cpu()

	33c3736ec888 cpu/hotplug: Hide cpu_up/down()

So I think except for suspend/resume/hibernate/kexec, all in-kernel users
should be serialized by lock(hotplug) now. Since uevents() don't matter for
suspend/resume/hiberante/kexec I think moving it outside of lock(cpu_maps) is
fine.

So IIUC in the past we had the race

	userspace			in-kernel users

	lock(hotplug)
	cpuhp_smt_disable()
	   lock(cpu_maps)		cpu_down()
					  lock(cpu_maps)

So they were serialized by cpu_maps lock. But that should not happen now since
in-kernel (except for the aforementioned) users should use remove_cpu().

	userspace			in-kernel users

	lock(hotplug)
	cpuhp_smt_disable()
	   lock(cpu_maps)		remove_cpu()
					  lock(hotplug)
					  device_offline()
					    cpu_down()
					      lock(cpu_maps)

Which forces the serialization at lock(hotplug), which is what
lock_device_hotplug_sysfs() is actually tries to hold.

So I think that race condition should not happen now. Or did I miss something?

The only loophole is that cpu_device_up() could be abused if not caught by
reviewers. I didn't find a way to warn/error if someone other than
cpu_subsys_online() uses it. We rely on a comment explaining it..

I think cpuhp_smt_disable/enable can safely call device_offline/online now.
Although it might still be more efficient to hold lock(cpu_maps) once than
repeatedly in a loop.

If we do that, then cpu_up_down_serialize_trainwrech() can be called from
cpu_device_up/down() which implies !task_frozen.

Can't remember now if Alexey moved the uevent() handling out of the loop for
efficiency reasons or was seeing something else. I doubt it was the latter.


Thanks

--
Qais Yousef
