Return-Path: <cgroups+bounces-6269-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E8FA1B32F
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 11:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3335018848A1
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 10:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3338C21A457;
	Fri, 24 Jan 2025 10:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Gasn0qMA"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4F7207A03
	for <cgroups@vger.kernel.org>; Fri, 24 Jan 2025 10:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737712847; cv=none; b=qD4/nSouNytxBzK6C7y2oP6KJPAHh4QrXybmijPTVh6uQVYstjencVhmnf/4cU00wwiDsO69jSB0qSKDGPHi+8TMqHfOKZhn2sC7GbKJXWMmH4DRG7Aa6OP3jKx/dxk8cFVfkpzbDYtxBycgQVF9K5H2FgBQGjBJxfOK/O8zUtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737712847; c=relaxed/simple;
	bh=sFprJVFwJ2E7g7E3sEaLKEWRDzMN6Z2rx69KzoKoQTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oU06APMMYGqjYVqs0CQavKdPMQ4P83wZ40tPBBIGv84di+K3NzSCf1zIt8MtXIyyxtcbgfJUKBKexQETpbz6XXAbTCkK0h4ZA80RNVyjkcxC74a3F0/PcieHH/4XBL1roE5Us1xmgVDTJ0+IrGFLfkjDiWHesjaLvlc/lq1Aa1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Gasn0qMA; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-215607278acso3684175ad.1
        for <cgroups@vger.kernel.org>; Fri, 24 Jan 2025 02:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1737712844; x=1738317644; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BmTxH03KXDQTDv/Uw7GBBM8E4pylSL3aSkfPVMzEuWQ=;
        b=Gasn0qMAqg7q9uMweLS6GNtSQWNHJSGBATclZoe5eiW7YafUqZHthM8V7O9VUXzkvl
         d6UZ49bq9cCT5MDx2qJHevfRNKLHTJIfRqPfol2QyfmXwTCZNdGfLpPhVUQNqOkJImjx
         aNXX+JR1iEzXOVcbRjrURLu5AY6S05qQbSt4E9jzZ2itJSeuE7W/sTRIIsJJ3yxeNQmk
         WYno/ey6UtlZbOJ03UMcaTvjKtDByEoUDuSs8IqALvvNOj7xNYcTQx0M1viaIPc8trGg
         WWMXeUrm8avKKTMN84ieCnDATmWQb3zZsPyHSaZbYkWMeBTWyyLlKvliCe3BJk2c1Ox/
         aczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737712844; x=1738317644;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BmTxH03KXDQTDv/Uw7GBBM8E4pylSL3aSkfPVMzEuWQ=;
        b=pWyMopxZWuQcsurx4d6pBKl36Km041AGZtkbQ+2oLTuo3d/reSQMHdpqyJ+pg6irdU
         z3DpU7MlHqOyfpqLFw0DhLHXjLstdma8a6/sZroxORw5wNULQG3qHVQpeL+hf/viM//r
         L6v9mQlh7I3vAmgt29+ER1NrESrgh/Hi/vmgk4DSUyMafr8Prg0Rt2B2PDdYUBeaJtDr
         tfXgc2oqL+iJ4Gm30Q4phj/zpc6ciuJLyUFb2oEQ9a57YCmlJ5lzyFJFOCSZx4N6PytO
         5Xz6dCww0lkSlHsdvzyY7gxkrx3MEHi2rosW0TbbsSj6+xvj/0b2chlJMhqYBcxNgO20
         wodw==
X-Forwarded-Encrypted: i=1; AJvYcCV4ceozT7uxKkelU4bAOPnvITHda3FEKBp2GdcFauBeXxGDHv46jKd1BwTxhodeGQIjxmb3LCVO@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc1FuLl98Z6jdZbyrcPfYLTj0aHd1XNd7bqNVQGP9vAMa+Hs70
	o3Cg1ASMAvmx9lkYxFjCDgdvQGS7I18rPJZyKhZwz7qpajvIQ4mZxCWyQe5bksA=
X-Gm-Gg: ASbGncubDOiT8etc8SQ72k+DAArlhXe49baGlDqQLw2umyetXoMVqy30NI8DfwVj9zU
	EWk1FPDNWYas6Ztesit67zrZiFHEblnc3LimtuxtK5TKEU9EyIGggbVnrlUR3DQnRhveyIWtpGH
	ziqwO3QAaaZoAQgdMFhPO8XGwkTC7rJZkWAb9t/uS32H8YoU2gs35X6K2TxaHBhLCQq725DWZf+
	FA4IVWdFv5hdDqojsZqS6lVK1WJOkK28d/D9MTWh/oNWOYsmJX9kCIVQIXPbNRGAWqkOPrYNVKR
	bGqZtFK3pAF8Qn77YRklgKRr5LYPPA==
X-Google-Smtp-Source: AGHT+IElO9gB3UAtHo+GuhS7uM8VXUkiIauC0sqTubx0f3SOShH1kUjljV5ZgDcKKMWCosxHHkPDQQ==
X-Received: by 2002:a05:6a00:21c7:b0:71e:4bda:71ec with SMTP id d2e1a72fcca58-72dafb9b2c7mr14455055b3a.4.1737712843813;
        Fri, 24 Jan 2025 02:00:43 -0800 (PST)
Received: from [10.254.144.106] ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a77c969sm1428288b3a.150.2025.01.24.02.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 02:00:43 -0800 (PST)
Message-ID: <764096dd-4d2c-4934-9c07-500a476bb140@bytedance.com>
Date: Fri, 24 Jan 2025 18:00:34 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] cgroup/rstat: Cleanup cpu.stat once for all
Content-Language: en-US
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Bitao Hu
 <yaoma@linux.alibaba.com>, Thomas Gleixner <tglx@linutronix.de>,
 Yury Norov <yury.norov@gmail.com>, Chen Ridong <chenridong@huawei.com>,
 "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250123174713.25570-1-wuyun.abel@bytedance.com>
 <20250123174713.25570-3-wuyun.abel@bytedance.com>
 <2fenjyawa46abfrpcebluaoi6dd4z5v2y7pp7jyuu2oblmfmhk@reaaehe6pkzn>
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <2fenjyawa46abfrpcebluaoi6dd4z5v2y7pp7jyuu2oblmfmhk@reaaehe6pkzn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/24/25 5:22 PM, Michal Koutný Wrote:
> On Fri, Jan 24, 2025 at 01:47:02AM +0800, Abel Wu <wuyun.abel@bytedance.com> wrote:
>> -static void cgroup_force_idle_show(struct seq_file *seq, struct cgroup_base_stat *bstat)
>> +static void __append_bstat(struct seq_file *seq, struct cgroup_base_stat *bstat,
>> +			   struct bstat_entry *entry)
> 
> Not sure if starting with double underscore is needed when the helper is
> `static`. Also something like s/append/show/ -> cgroup_bstat_entry_show.

Yeah, "cgroup_bstat_entry_show" looks better! Will fix.

Thanks,
	Abel


