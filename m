Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 451B126A97
	for <lists+cgroups@lfdr.de>; Wed, 22 May 2019 21:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbfEVTKf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 May 2019 15:10:35 -0400
Received: from smtprelay0186.hostedemail.com ([216.40.44.186]:36296 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729018AbfEVTKf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 May 2019 15:10:35 -0400
X-Greylist: delayed 599 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 May 2019 15:10:34 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave02.hostedemail.com (Postfix) with ESMTP id 90D6E18024508;
        Wed, 22 May 2019 18:54:36 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 60240182251DF;
        Wed, 22 May 2019 18:54:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::::,RULES_HIT:41:69:355:379:599:800:960:966:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1535:1544:1593:1594:1711:1730:1747:1777:1792:2196:2199:2393:2559:2562:2828:2896:3138:3139:3140:3141:3142:3355:3622:3866:3870:3871:3872:4321:4385:4605:5007:6119:6742:8784:10004:10848:11026:11232:11473:11658:11914:12043:12296:12438:12555:12679:12740:12760:12895:12986:13439:14096:14097:14181:14254:14659:14721:21080:21325:21451:21611:21627:30001:30002:30003:30004:30005:30006:30007:30008:30009:30010:30011:30012:30013:30014:30015:30016:30017:30018:30019:30020:30021:30022:30023:30024:30025:30026:30027:30028:30029:30030:30031:30032:30033:30034:30035:30036:30037:30038:30039:30040:30041:30042:30043:30044:30045:30046:30047:30048:30049:30050:30051:30052:30053:30054:30055:30057:30058:30059:30060:30061:30062:30063:30064:30065:30066:30067:30068:30069:30070:30071:30072:30073:30074:30075:30076:30077:3007
X-HE-Tag: beds74_27dc26fe10b2d
X-Filterd-Recvd-Size: 5469
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Wed, 22 May 2019 18:54:33 +0000 (UTC)
Message-ID: <8ae488765c8d441dbb444adaf89e59a2afa81298.camel@perches.com>
Subject: Re: [PATCH] Fix comments with paths pointing to renamed or moved
 files.
From:   Joe Perches <joe@perches.com>
To:     Pavel Machek <pavel@ucw.cz>,
        Lukas Prause <langspielplatte@black-mesa.xyz>
Cc:     lizefan@huawei.com, tj@kernel.org, hannes@cmpxchg.org,
        peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com,
        rjw@rjwysocki.net, len.brown@intel.com, rostedt@goodmis.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-pm@vger.kernel.org,
        Lennart Glauer <mail@lennart-glauer.de>
Date:   Wed, 22 May 2019 11:54:31 -0700
In-Reply-To: <20190522183614.GD10003@amd>
References: <20190521155430.14941-1-langspielplatte@black-mesa.xyz>
         <20190522183614.GD10003@amd>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 2019-05-22 at 20:36 +0200, Pavel Machek wrote:
> On Tue 2019-05-21 17:54:30, Lukas Prause wrote:
> > This patch corrects renamed or moved paths in comments.
> > 
> > Signed-off-by: Lukas Prause <langspielplatte@black-mesa.xyz>
> > Signed-off-by: Lennart Glauer <mail@lennart-glauer.de>
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> > diff --git a/kernel/power/power.h b/kernel/power/power.h
> > index 9e58bdc8a562..5de8b0c7f657 100644
> > --- a/kernel/power/power.h
> > +++ b/kernel/power/power.h
> > @@ -182,7 +182,7 @@ extern int swsusp_unmark(void);
> >  #endif
> >  
> >  struct timeval;
> > -/* kernel/power/swsusp.c */
> > +/* kernel/power/hibernate.c */
> >  extern void swsusp_show_speed(ktime_t, ktime_t, unsigned int, char *);
> >  
> >  #ifdef CONFIG_SUSPEND

I think all of these markings should be removed instead.
Why are these useful?
It seems many of these filenames in power.h aren't correct anyway.

For instance power.h has:

   /* kernel/power/hibernate.c */
   extern int swsusp_check(void);
   extern void swsusp_free(void);
   extern int swsusp_read(unsigned int *flags_p);
   extern int swsusp_write(unsigned int flags);
   extern void swsusp_close(fmode_t);
   #ifdef CONFIG_SUSPEND
   extern int swsusp_unmark(void);
   #endif

but:

swsusp_check is in swap.c
swsusp_free is in snapshot.c
swsusp_read is in swap.c

etc...

Perhaps:
---
 kernel/power/power.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/kernel/power/power.h b/kernel/power/power.h
index 9e58bdc8a562..52bcb72564e5 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -16,7 +16,6 @@ struct swsusp_info {
 } __aligned(PAGE_SIZE);
 
 #ifdef CONFIG_HIBERNATION
-/* kernel/power/snapshot.c */
 extern void __init hibernate_reserved_size_init(void);
 extern void __init hibernate_image_size_init(void);
 
@@ -55,7 +54,6 @@ extern int hibernate_resume_nonboot_cpu_disable(void);
 
 asmlinkage int swsusp_save(void);
 
-/* kernel/power/hibernate.c */
 extern bool freezer_test_done;
 
 extern int hibernation_snapshot(int platform_mode);
@@ -63,7 +61,6 @@ extern int hibernation_restore(int platform_mode);
 extern int hibernation_platform_enter(void);
 
 #ifdef CONFIG_STRICT_KERNEL_RWX
-/* kernel/power/snapshot.c */
 extern void enable_restore_image_protection(void);
 #else
 static inline void enable_restore_image_protection(void) {}
@@ -171,7 +168,6 @@ extern int swsusp_swap_in_use(void);
 #define SF_NOCOMPRESS_MODE	2
 #define SF_CRC32_MODE	        4
 
-/* kernel/power/hibernate.c */
 extern int swsusp_check(void);
 extern void swsusp_free(void);
 extern int swsusp_read(unsigned int *flags_p);
@@ -182,11 +178,9 @@ extern int swsusp_unmark(void);
 #endif
 
 struct timeval;
-/* kernel/power/swsusp.c */
 extern void swsusp_show_speed(ktime_t, ktime_t, unsigned int, char *);
 
 #ifdef CONFIG_SUSPEND
-/* kernel/power/suspend.c */
 extern const char * const pm_labels[];
 extern const char *pm_states[];
 extern const char *mem_sleep_states[];
@@ -202,7 +196,6 @@ static inline int suspend_devices_and_enter(suspend_state_t state)
 #endif /* !CONFIG_SUSPEND */
 
 #ifdef CONFIG_PM_TEST_SUSPEND
-/* kernel/power/suspend_test.c */
 extern void suspend_test_start(void);
 extern void suspend_test_finish(const char *label);
 #else /* !CONFIG_PM_TEST_SUSPEND */
@@ -211,7 +204,6 @@ static inline void suspend_test_finish(const char *label) {}
 #endif /* !CONFIG_PM_TEST_SUSPEND */
 
 #ifdef CONFIG_PM_SLEEP
-/* kernel/power/main.c */
 extern int __pm_notifier_call_chain(unsigned long val, int nr_to_call,
 				    int *nr_calls);
 extern int pm_notifier_call_chain(unsigned long val);
@@ -289,7 +281,6 @@ static inline void suspend_thaw_processes(void)
 
 #ifdef CONFIG_PM_AUTOSLEEP
 
-/* kernel/power/autosleep.c */
 extern int pm_autosleep_init(void);
 extern int pm_autosleep_lock(void);
 extern void pm_autosleep_unlock(void);
@@ -307,7 +298,6 @@ static inline suspend_state_t pm_autosleep_state(void) { return PM_SUSPEND_ON; }
 
 #ifdef CONFIG_PM_WAKELOCKS
 
-/* kernel/power/wakelock.c */
 extern ssize_t pm_show_wakelocks(char *buf, bool show_active);
 extern int pm_wake_lock(const char *buf);
 extern int pm_wake_unlock(const char *buf);


