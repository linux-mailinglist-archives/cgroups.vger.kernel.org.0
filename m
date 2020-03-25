Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 172CF1930FD
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2020 20:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgCYTT1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 Mar 2020 15:19:27 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42031 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbgCYTT0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 Mar 2020 15:19:26 -0400
Received: by mail-qt1-f193.google.com with SMTP id t9so3204697qto.9;
        Wed, 25 Mar 2020 12:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rOPBVRyRj22r/QAr9s4b9CBOGy0xlM6KuJUxnB7ao+I=;
        b=WshBHS0wCQtRNGoEZsyzPMrxTJcVcepRsbvcpB1+hCJTpUBqa7ilY0cDflaaTzY0D+
         uuPEzzE2uM7eb/nZ0dwz2vQpq8xuKrREIdIVHuh1pixYEMyM+0/VFQqEKjYCQLmcvCoT
         VLXYgbgKtuUxFrVXKmAZsa4SQLponxT8Kush70OqvoWnIB4OCkzALZv/8lKYOXhKkdKb
         qlWfDaAFjW7GhpB/atmTETI+rYYxr1gufl0fZvq4474QfO6PTT7jCII1aDcQyQg/CUxX
         uA9anhzPVs0Zu7KLoWDg++XyTOIXQYVrFRiPJ7IG1SJtvv9/0XoeIZPm1i1TNET1liF3
         xCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=rOPBVRyRj22r/QAr9s4b9CBOGy0xlM6KuJUxnB7ao+I=;
        b=qceDLoijw2YfXoPGdcNtywgIYGW5wMmViS6uY3+HakU/neTwZQmK4OpYIhDJWyN3g8
         PaHuJUAMjWIRN88/fqwoigQkKt3lQ0a5GRnNxBExfdVB6jE+V+Hnm2WLeSIkq2NkcH4i
         xqPGrISTZccXrJv/7YmphxTz90qJXGtDu+udIFJvGBlpEVX8tta6dC1RX5Zzz6SytjJC
         B422S/wtE0K+M/Dlc8fgeKGK49BTEx1p1GSykKUJFfkWyTUftv2kcQwCTeWxj0+40KnN
         Y5AqZT1ujOabaoNum2CXrchK7NfkD+sezUX2G5xLtP+tTzLjEyRnCEHc8x4sfzLTUob5
         HTdQ==
X-Gm-Message-State: ANhLgQ2xIZ2mc/CHTjwudLUkHHazv7UhXj31VLQR7o5AVLWYZCbvY1yJ
        INIcrdNvsYKzmCKUu6EHZQc=
X-Google-Smtp-Source: ADFU+vuaylKzh2WDvL6nXEaYyf0iBNZxB/JqfhMsuKd4DsgrMsWOHRt03W96QML3WCec3KuEmA0vBw==
X-Received: by 2002:aed:200f:: with SMTP id 15mr4567779qta.152.1585163965488;
        Wed, 25 Mar 2020 12:19:25 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::d8d4])
        by smtp.gmail.com with ESMTPSA id z18sm18199199qtz.77.2020.03.25.12.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 12:19:24 -0700 (PDT)
Date:   Wed, 25 Mar 2020 15:19:22 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Prateek Sood <prsood@codeaurora.org>,
        Li Zefan <lizefan@huawei.com>, cgroups@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: Deadlock due to "cpuset: Make cpuset hotplug synchronous"
Message-ID: <20200325191922.GM162390@mtj.duckdns.org>
References: <F0388D99-84D7-453B-9B6B-EEFF0E7BE4CC@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F0388D99-84D7-453B-9B6B-EEFF0E7BE4CC@lca.pw>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 25, 2020 at 03:16:56PM -0400, Qian Cai wrote:
> The linux-next commit a49e4629b5ed (“cpuset: Make cpuset hotplug synchronous”)
> introduced real deadlocks with CPU hotplug as showed in the lockdep splat, since it is
> now making a relation from cpu_hotplug_lock —> cgroup_mutex.

Prateek, can you please take a look? Given that the merge window is just around
the corner, we might have to revert and retry later if it can't be resolved
quickly.

Thanks.

-- 
tejun
