Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC8E79838
	for <lists+cgroups@lfdr.de>; Mon, 29 Jul 2019 22:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390128AbfG2UGM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Jul 2019 16:06:12 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:44342 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389378AbfG2UGK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Jul 2019 16:06:10 -0400
Received: by mail-pg1-f174.google.com with SMTP id i18so28787178pgl.11;
        Mon, 29 Jul 2019 13:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P3EUM+tzT2Mr9lYyH9h+ka7j8G70ef8Dl2l22x1qowY=;
        b=e68jNLw0799EKEVQytct+JZQNey8bkPM//gc4ZFMDQZt6EuWjdKKRGpVlCTMWq7Iqo
         A+dcRsjM4FizcWmU+Pe5CRlrHn1pVvJyOmfNMEJfMlsdrGvxgecpZ/Vz2EjV+oGs4zZv
         caDGsF7LjY/bt2zUP/pfgLlCSthMkMgm0P30KycyqAo/vHsx4JIUHzrLR6z1YlWrQHF2
         Z/O54RfdGRdkJdCERpIQTbLh8SD1teL8PkDFWC337LABr2NOIPBHPVBaqvBIZ+Fjr6S9
         FQfjphUq5UIZmZbQAPaqMS0yFAL1KgtnRWEoarVjXw+oyOU2oF5/pLul9G4CyNiLufzV
         Aw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=P3EUM+tzT2Mr9lYyH9h+ka7j8G70ef8Dl2l22x1qowY=;
        b=K0G2ea8spd/u+MUgfpYWYg15RnGE/neEKE6wyFmPyvIRcrlQ2cX9ZjA0sf2Fh3gFb2
         KKpRoRJhrPDIFTcbP62EK/mYDyI/n61X8dH2+Nmcu6bUVd/ictAjHYzRb/iyRhwInc2J
         VfT3FSH2d5lZRUTo6vLAJdkyI7lgQ4Bdjr2LAbijwcxgSI7Xjx5nuL7tkZioFRb3ciX2
         WRFkFvARUd9WE15K8+6sQ5VpkuqWOAwb5x2xAeO3Jrk7HucqJlS0W0ayOYeAByDn4Rjc
         kJ65WBBjp8wdL0pQeXDQVdmq3/QWrD3UPygf1K07SI8xZqbpNgtCWMssI+/HcZ+RdSRP
         af5Q==
X-Gm-Message-State: APjAAAWUtjO+Yqq1eWoCTqKnLVytZN8G9wQ8GPkwUnh51pPtmuN+rNpc
        Gb33s1Vp7AChrDyQifW3x9k=
X-Google-Smtp-Source: APXvYqx8/ZCCakSV0L+VbVZZR4VTz4XJbOiCwNm038NWGAf8GVPi+6hwZfOg57M6dniSlHu1GcB3ag==
X-Received: by 2002:a63:ab08:: with SMTP id p8mr16604294pgf.340.1564430768869;
        Mon, 29 Jul 2019 13:06:08 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:309b])
        by smtp.gmail.com with ESMTPSA id b24sm31938348pfd.91.2019.07.29.13.06.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 13:06:08 -0700 (PDT)
Date:   Mon, 29 Jul 2019 13:06:06 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, cgroups@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>, Michal Koutny <mkoutny@suse.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alessio Balsini <balsini@android.com>
Subject: Re: [PATCH v12 0/6] Add utilization clamping support (CGroups API)
Message-ID: <20190729200606.GA136335@devbig004.ftw2.facebook.com>
References: <20190718181748.28446-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718181748.28446-1-patrick.bellasi@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

Looks good to me.  On cgroup side,

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
