Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1828C18389B
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2020 19:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgCLS0Z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Mar 2020 14:26:25 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]:39977 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgCLS0Y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Mar 2020 14:26:24 -0400
Received: by mail-qk1-f179.google.com with SMTP id m2so7903183qka.7;
        Thu, 12 Mar 2020 11:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eViXmXzzaMR0CsZTGCPQ+TrKF+BfmVsvrf179rOhgZI=;
        b=vaPuM3qaA0oNIgyjxBq9fo3DjzTSplT6RX2awoFL63OjPQPW+ohK7ZmosBeMwA33rp
         gl4GllPZLcLHYZjGqrIAb/x62R4MxbseghAwoKVUWsFKml4ds2fxEWkE9HZwDll19KCn
         +Qmm33d/9prjdKrV8qLAkUOCwW/Ea0XxuIeTMbHrR2CbhUESvN7ZOnpAX2IWxAiyHYiO
         5K3TXt2oMTzXZSTkU86QSSKimtBUmLZGpezZ/So5SG5QdO/JbE9q+Tfj2/Hv0NoOlagI
         01At2u7pl/YpF9OLfCOZvE2pgd/wPC2cfGrm2fjJhcbN6NhoXPI1h8i0Eut9nII5A4zE
         v+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=eViXmXzzaMR0CsZTGCPQ+TrKF+BfmVsvrf179rOhgZI=;
        b=tvVCZjofpyJSw+52CBywO0HmdV280TCyCx4zGx5Eijwt/9rbjtkkU17qK74oSp3hI2
         zRIvOrnxqZu+a3+4bv1uLI+clYZwm/8S7O1PhJMhsdiC+Au4Z05rPiFyrv7w7BKwa2Rq
         mda70DGCGkKizQ5v1Q4YO/9UQLRO/RT8MM6MR+H1kKZzFEvMUuVAo75TR/07SARFongp
         2/qw/b8rkckaz5WnFdF3LenWSADu3JFDY+fwnH952/zmPgH0FM9pP7mcxnvZhOn01jf3
         V2TD/WemqbOmR6plAMs0pYTyuPC9VljZ6qVPkqqbRQxa7z4Io/NPMXuFZHbUo5zYSGPe
         v8jA==
X-Gm-Message-State: ANhLgQ1rxkQxKtokQ+/cGTizzeTZWhPKoubZTVQMLzuhT93SC71iDqmM
        ORMmLtfyAF2PfjFPp+famLA=
X-Google-Smtp-Source: ADFU+vuSs61upK+TjtMnwkwDaFblKOn/W4AW9D1KUmOKg0mrUt9SiU0Iual9VBPRl8Yt1pbxKR6uLQ==
X-Received: by 2002:a05:620a:136b:: with SMTP id d11mr9458989qkl.11.1584037582041;
        Thu, 12 Mar 2020 11:26:22 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::fec8])
        by smtp.gmail.com with ESMTPSA id i4sm28102735qkf.111.2020.03.12.11.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 11:26:21 -0700 (PDT)
Date:   Thu, 12 Mar 2020 14:26:19 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Li Zefan <lizefan@huawei.com>, cgroups <cgroups@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [regression] cpuset: offlined CPUs removed from affinity masks
Message-ID: <20200312182618.GE79873@mtj.duckdns.org>
References: <1251528473.590671.1579196495905.JavaMail.zimbra@efficios.com>
 <20200219151922.GB698990@mtj.thefacebook.com>
 <1589496945.670.1582126985824.JavaMail.zimbra@efficios.com>
 <20200219154740.GD698990@mtj.thefacebook.com>
 <59426509.702.1582127435733.JavaMail.zimbra@efficios.com>
 <20200219155202.GE698990@mtj.thefacebook.com>
 <1358308409.804.1582128519523.JavaMail.zimbra@efficios.com>
 <20200219161222.GF698990@mtj.thefacebook.com>
 <316507033.21078.1583597207356.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <316507033.21078.1583597207356.JavaMail.zimbra@efficios.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Sat, Mar 07, 2020 at 11:06:47AM -0500, Mathieu Desnoyers wrote:
> Looking into solving this, one key issue seems to get in the way: cpuset
> appear to care about not allowing to create a cpuset which has no currently
> active CPU where to run, e.g.:
...
> Clearly, there is an intent that cpusets take the active mask into
> account to prohibit creating an empty cpuset, but nothing prevents
> cpu hotplug from creating an empty cpuset.
> 
> I wonder how to solve this inconsistency ?

Please try cpuset in cgroup2. It shouldn't have those issues.

Thanks.

-- 
tejun
