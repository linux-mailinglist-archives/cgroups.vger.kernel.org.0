Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 022272861E
	for <lists+cgroups@lfdr.de>; Thu, 23 May 2019 20:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731525AbfEWSow (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 May 2019 14:44:52 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:45270 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731523AbfEWSow (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 May 2019 14:44:52 -0400
Received: by mail-ot1-f50.google.com with SMTP id t24so6355133otl.12
        for <cgroups@vger.kernel.org>; Thu, 23 May 2019 11:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=indeed.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=yNILfyJChXA1qHX1Kqi1owLnUHep4ERKIkS79Wu1+tk=;
        b=ytyrCd/qOMiw0SMCH3uGeCH96UCKXfeNngBh+3fqTLyrvfr3w1CggUfgpYbxePvNdH
         mgBFPc9L9iqibPjumTk2GvTbWndammyucmWOw7SoENj+v2wcyYufN6wiTU612eG5yOFW
         L3WLFb7W/s9PKX9oom+IMNnX0YkzBTk+WZOnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=yNILfyJChXA1qHX1Kqi1owLnUHep4ERKIkS79Wu1+tk=;
        b=rX+YDXLcNX+HEzohd3smXRgsBi04Ix3X8pTxFCvfJ6FNO4i8HAFJIG4CmWTlAoyxwY
         36Wjs8evHiwyA/4mp0YIbgebcKn9tY37aBfU8dYKVZn2llBQf4DZ+XjwTji3izr0ROXk
         gBsOQyp9ZUKSiTcwzjffl89mc6c0c76IG9HcRfV1GzYLxOT5pKd3HIdCJBKEKDfQR5L7
         5DK9lXXKR+tpUZ5VtXQKXgORNFvbOKd0KsAV6B2TFZxt41VDfm3S2guVyKdRnvjBEWct
         b65Rs/mYrkmqLQ7YUyggl85qWatCafm/RCo0JdsWoHbmg6nRKBlC5s+kPDft6h9gTlKy
         1WLw==
X-Gm-Message-State: APjAAAWRy5OgVKKvdZjlr+1HBGfEt0n4QaMwL7aafJ/ny5bsk72jYQ0c
        IeATq4z6Pa5GaefgEDA2cL2p3Q==
X-Google-Smtp-Source: APXvYqzrg3W4K8wR2ebTIsIl4Uob3uxGrA1mPsTDJ1btsxIfLnHK4XWZ6ckIo/J0Nrexypt51+CS8w==
X-Received: by 2002:a9d:7a93:: with SMTP id l19mr3843085otn.49.1558637091094;
        Thu, 23 May 2019 11:44:51 -0700 (PDT)
Received: from cando.ausoff.indeed.net ([97.105.47.162])
        by smtp.gmail.com with ESMTPSA id s63sm83801oia.34.2019.05.23.11.44.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 11:44:50 -0700 (PDT)
From:   Dave Chiluk <chiluk+linux@indeed.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brendan Gregg <bgregg@netflix.com>,
        Kyle Anderson <kwa@yelp.com>,
        Gabriel Munos <gmunoz@netflix.com>,
        John Hammond <jhammond@indeed.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH v2 0/1] sched/fair: Fix low cpu usage with high throttling by removing expiration of cpu-local slices
Date:   Thu, 23 May 2019 13:44:46 -0500
Message-Id: <1558637087-20283-1-git-send-email-chiluk+linux@indeed.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1558121424-2914-1-git-send-email-chiluk+linux@indeed.com>
References: <1558121424-2914-1-git-send-email-chiluk+linux@indeed.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Changelog v2
    - Fixed some checkpatch errors in the commit message.
