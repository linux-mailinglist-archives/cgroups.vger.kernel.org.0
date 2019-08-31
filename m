Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22C5CA4238
	for <lists+cgroups@lfdr.de>; Sat, 31 Aug 2019 06:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbfHaE3C (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 31 Aug 2019 00:29:02 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40461 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfHaE3C (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 31 Aug 2019 00:29:02 -0400
Received: by mail-qt1-f195.google.com with SMTP id g4so9962890qtq.7
        for <cgroups@vger.kernel.org>; Fri, 30 Aug 2019 21:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lwpweyXTk6HuzAJ3GT4M5AgAi7POAAcap2BBTFJnQKA=;
        b=s4i3FNlgFD8ikcxdRUW9iyjInekAGuqySbkYtiCnZrBoM3n2abUChr3xu+YjPn2UeP
         SykfSiquLyhfi4A+zVQ2kCRJTq+IgIsFjM5GSUM5Sgo8S45OxRn7UELBp6qLZDXLrKMn
         ZQtWrhyq3fxz+vXbqeM/+Hs28Tuc/D29ObEUpXcmZnWndxLG/1GuZRu6CwqZsptwnHHn
         Pr8PW0QYlJb94sObK59mwoJtxuPv+SQIqU1el8UP3Kq9iufrR/lJ/UsSYecnh2+0lAFr
         hKpdpidNq70c3DVm2Lhkb8f426HKWIuUw82lnc7/7wWniCdtaCaw4HsxXqRDnAXs8q18
         uDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=lwpweyXTk6HuzAJ3GT4M5AgAi7POAAcap2BBTFJnQKA=;
        b=pnVaIE9jwE1Ti7ENQRH8rGhAUibxnKfgw7Ni+wIn+CqYNFlIaePbpBOzIptmVNYuel
         ISN8U4UjI/V1UtQl4N0spE518ftQKLNezeQlhmpsRlnNFC/4BJJCVt16kWsxFu30zI2H
         fu9Ii+l1hQxbV5S/N2hlb5ac/C75gHlSZgPttjvYazw780mgim79jIDs7mzzg16jl6UZ
         UJNskXUbK1t7gd+4Vh7ibINPGf4USWSzrConNED4vKM4WzrC0fmcGdeVJ0QKM8Ch9WGX
         ZXCOBJ/YmZ/HqyQOoY8CyMmQGDeMb61GEKEhG3i7ugV5TaRMLn0UA2QfIRnNO1WRIU6w
         hFlA==
X-Gm-Message-State: APjAAAWuCpdXK7nRPnL4/ZLKbESAHq2SXWwgIeZ041+WpVmRbWZNmnPW
        82mOLVhMUtxl9Iv7ukIWJP8=
X-Google-Smtp-Source: APXvYqwv/d6bQT0uOGUplb1qCVSd9gQ0DTwUq6yaI6aQuWJmq4AEjRK6Y1RNpwGnJxVqcbfL6aE46g==
X-Received: by 2002:ac8:4787:: with SMTP id k7mr1124028qtq.58.1567225741341;
        Fri, 30 Aug 2019 21:29:01 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::ca48])
        by smtp.gmail.com with ESMTPSA id n42sm2428453qta.31.2019.08.30.21.29.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 21:29:00 -0700 (PDT)
Date:   Fri, 30 Aug 2019 21:28:57 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Kenny Ho <Kenny.Ho@amd.com>
Cc:     y2kenny@gmail.com, cgroups@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        felix.kuehling@amd.com, joseph.greathouse@amd.com,
        jsparks@cray.com, lkaplan@cray.com, daniel@ffwll.ch
Subject: Re: [PATCH RFC v4 00/16] new cgroup controller for gpu/drm subsystem
Message-ID: <20190831042857.GD2263813@devbig004.ftw2.facebook.com>
References: <20190829060533.32315-1-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829060533.32315-1-Kenny.Ho@amd.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

I just glanced through the interface and don't have enough context to
give any kind of detailed review yet.  I'll try to read up and
understand more and would greatly appreciate if you can give me some
pointers to read up on the resources being controlled and how the
actual use cases would look like.  That said, I have some basic
concerns.

* TTM vs. GEM distinction seems to be internal implementation detail
  rather than anything relating to underlying physical resources.
  Provided that's the case, I'm afraid these internal constructs being
  used as primary resource control objects likely isn't the right
  approach.  Whether a given driver uses one or the other internal
  abstraction layer shouldn't determine how resources are represented
  at the userland interface layer.

* While breaking up and applying control to different types of
  internal objects may seem attractive to folks who work day in and
  day out with the subsystem, they aren't all that useful to users and
  the siloed controls are likely to make the whole mechanism a lot
  less useful.  We had the same problem with cgroup1 memcg - putting
  control of different uses of memory under separate knobs.  It made
  the whole thing pretty useless.  e.g. if you constrain all knobs
  tight enough to control the overall usage, overall utilization
  suffers, but if you don't, you really don't have control over actual
  usage.  For memcg, what has to be allocated and controlled is
  physical memory, no matter how they're used.  It's not like you can
  go buy more "socket" memory.  At least from the looks of it, I'm
  afraid gpu controller is repeating the same mistakes.

Thanks.

-- 
tejun
